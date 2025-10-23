# frozen_string_literal: true

module Tcx
  class Base < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared

    def self.parse(xml)
      attributes = xml.attributes.to_h

      xml.children.each do |child|
        next unless child.is_a?(Nokogiri::XML::Element)

        attributes[child.name] = if attributes.key?(child.name)
                                   to_array(attributes[child.name]) + [child]
                                 elsif child.children.one? && child.children.first.is_a?(Nokogiri::XML::Text)
                                   child.text
                                 else
                                   child
                                 end
      end

      new attributes
    end

    # Transform an XmlElement into [XmlElement], cannot be used with Array or causes a coercion error
    def self.to_array(value)
      value.is_a?(Array) ? value : [value]
    end

    def self.attributes
      []
    end

    def attributes
      attribute_values = {}
      self.class.attributes.each do |attribute|
        value = self[attribute]
        next unless value

        property_name = self.class.inverse_translations.fetch(attribute, attribute)
        attribute_values[property_name] = build_value(value)
      end
      attribute_values
    end

    def build(builder)
      (self.class.properties - self.class.attributes).each do |property|
        value = self[property]
        next unless value

        property_name = self.class.inverse_translations.fetch(property, property)

        if value.is_a?(Base)
          builder.send(property_name, value.attributes) do |property_builder|
            value.build(property_builder)
          end
        elsif value.is_a?(Array)
          value.each do |el|
            attributes = el.attributes if el.is_a?(Base)
            builder.send(property_name, attributes) do |value_builder|
              el.build(value_builder)
            end
          end
        else
          builder.send(property_name, build_value(value))
        end
      end
    end

    def build_value(value)
      case value
      when Time
        value.iso8601.gsub('Z', '.000Z')
      else
        value
      end
    end
  end
end
