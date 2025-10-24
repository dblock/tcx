# frozen_string_literal: true

module Tcx
  class Base < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    extend Forwardable

    def self.parse(xml)
      if (tt = xml['xsi:type'])
        klass = Tcx.const_get(tt.gsub(/_t$/, ''))
        return klass.parse(xml) if self != klass
      end

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

    def self.namespace
      'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'
    end

    def self.namespace_definitions
      {
        'xsi:schemaLocation' => 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2 http://www.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd',
        'xmlns' => 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2',
        'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
        'xmlns:ns2' => 'http://www.garmin.com/xmlschemas/UserProfile/v2',
        'xmlns:ns3' => 'http://www.garmin.com/xmlschemas/ActivityExtension/v2',
        'xmlns:ns4' => 'http://www.garmin.com/xmlschemas/ProfileExtension/v1',
        'xmlns:ns5' => 'http://www.garmin.com/xmlschemas/ActivityGoals/v1'
      }
    end

    def self.xmlns
      @xmlns ||= namespace_definitions.invert
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

    def build_xml(builder, namespace = nil)
      (self.class.properties - self.class.attributes).each do |property|
        value = self[property]
        next unless value

        property_name = self.class.inverse_translations.fetch(property, property)

        if value.is_a?(Base)
          build_el(builder, property_name, value)
        elsif value.is_a?(Array)
          value.each do |el|
            build_el(builder, property_name, el)
          end
        else
          builder = builder[namespace] if namespace
          builder.send(property_name, build_value(value))
        end
      end
    end

    def build_el(builder, property_name, el)
      attributes = el.attributes if el.is_a?(Base)
      namespace = Base.xmlns[el.class.namespace]&.split(':')&.[](1) if el.is_a?(Base)
      builder = builder[namespace] if namespace

      builder.send(property_name, attributes) do |property_builder|
        el.build_xml(property_builder, namespace)
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
