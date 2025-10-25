# frozen_string_literal: true

module Tcx
  class Base < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    extend Forwardable

    DEFAULT_NAMESPACE = 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'

    # TODO: dynamically register additional namespaces to support custom extensions
    DEFAULT_NAMESPACE_DEFINITIONS = {
      'xsi:schemaLocation' => 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2 http://www.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd',
      'xmlns' => 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2',
      'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
      'xmlns:ns2' => 'http://www.garmin.com/xmlschemas/UserProfile/v2',
      'xmlns:ns3' => 'http://www.garmin.com/xmlschemas/ActivityExtension/v2',
      'xmlns:ns4' => 'http://www.garmin.com/xmlschemas/ProfileExtension/v1',
      'xmlns:ns5' => 'http://www.garmin.com/xmlschemas/ActivityGoals/v1'
    }.freeze

    INVERTED_DEFAULT_NAMESPACE_DEFINITIONS = DEFAULT_NAMESPACE_DEFINITIONS.invert.freeze

    class << self
      def parse(xml)
        klass = to_class(xml['xsi:type'])
        return klass.parse(xml) if klass

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
      def to_array(value)
        value.is_a?(Array) ? value : [value]
      end

      def to_class(xsi_type)
        return unless xsi_type

        # TODO: not all extension types are Type_t
        klass = Tcx.const_get(xsi_type.gsub(/_t$/, ''))
        self == klass ? nil : klass
      rescue NameError # extension not implemented
        nil
      end

      def attributes
        []
      end

      def namespace
        DEFAULT_NAMESPACE
      end
    end

    def attributes
      self.class.attributes.map do |attribute|
        value = self[attribute]
        next unless value

        property_name = self.class.inverse_translations.fetch(attribute, attribute)
        [property_name, build_value(value)]
      end.compact.to_h
    end

    def build_xml(builder, namespace = nil)
      (self.class.properties - self.class.attributes).each do |property|
        value = self[property]
        next unless value

        property_name = self.class.inverse_translations.fetch(property, property)

        case value
        when Base
          build_el(builder, property_name, value)
        when Array
          value.each do |element|
            build_el(builder, property_name, element)
          end
        else
          builder = builder[namespace] if namespace
          builder.send(property_name, build_value(value))
        end
      end
    end

    def namespace_definitions
      DEFAULT_NAMESPACE_DEFINITIONS
    end

    def inverted_namespace_definitions
      @inverted_namespace_definitions ||= if namespace_definitions == DEFAULT_NAMESPACE_DEFINITIONS
                                            INVERTED_DEFAULT_NAMESPACE_DEFINITIONS
                                          else
                                            namespace_definitions.invert
                                          end
    end

    private

    def build_el(builder, property_name, element)
      attributes = element.attributes if element.is_a?(Base)
      namespace = inverted_namespace_definitions[element.class.namespace]&.split(':')&.[](1) if element.is_a?(Base)
      builder = builder[namespace] if namespace

      builder.send(property_name, attributes) do |property_builder|
        element.build_xml(property_builder, namespace)
      end
    end

    def build_value(value)
      case value
      when ::Time
        value.iso8601
      else
        value
      end
    end
  end
end
