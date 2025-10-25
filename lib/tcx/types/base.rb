# frozen_string_literal: true

module Tcx
  # Base
  #
  # Abstract base class for all TCX types. Provides XML parsing and serialization
  # functionality using Hashie::Trash for property mapping.
  #
  # This class implements the core functionality for:
  #   - Parsing XML elements into Ruby objects
  #   - Building XML from Ruby objects
  #   - Handling XML namespaces and schema locations
  #   - Supporting polymorphism via xsi:type attributes
  #   - Property transformation and coercion
  #
  # All TCX type classes inherit from Base and define their properties using
  # Hashie's property DSL with transform_with for type conversions.
  #
  # @see Database
  # @see Activity
  # @see Workout
  class Base < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    extend Forwardable

    # Default XML namespace for TCX v2 schema
    DEFAULT_NAMESPACE = 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'

    # TODO: dynamically register additional namespaces to support custom extensions

    # Default namespace definitions for TCX XML documents
    # Maps namespace prefixes to their URIs
    DEFAULT_NAMESPACE_DEFINITIONS = {
      'xsi:schemaLocation' => 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2 http://www.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd',
      'xmlns' => 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2',
      'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
      'xmlns:ns2' => 'http://www.garmin.com/xmlschemas/UserProfile/v2',
      'xmlns:ns3' => 'http://www.garmin.com/xmlschemas/ActivityExtension/v2',
      'xmlns:ns4' => 'http://www.garmin.com/xmlschemas/ProfileExtension/v1',
      'xmlns:ns5' => 'http://www.garmin.com/xmlschemas/ActivityGoals/v1'
    }.freeze

    # Inverted namespace definitions for efficient reverse lookups
    INVERTED_DEFAULT_NAMESPACE_DEFINITIONS = DEFAULT_NAMESPACE_DEFINITIONS.invert.freeze

    class << self
      # Parse an XML element into a TCX object
      # Handles polymorphism via xsi:type attributes
      # @param xml [Nokogiri::XML::Element] XML element to parse
      # @return [Base] parsed TCX object
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

      # Transform an XmlElement into [XmlElement]
      # Cannot be used with Array or causes a coercion error
      # @param value [Nokogiri::XML::Element, Array] value to convert
      # @return [Array] array containing the value(s)
      def to_array(value)
        value.is_a?(Array) ? value : [value]
      end

      # Convert xsi:type string to Ruby class
      # @param xsi_type [String, nil] xsi:type attribute value
      # @return [Class, nil] TCX class or nil
      def to_class(xsi_type)
        return unless xsi_type

        # TODO: not all extension types are Type_t
        klass = Tcx.const_get(xsi_type.gsub(/_t$/, ''))
        self == klass ? nil : klass
      rescue NameError # extension not implemented
        nil
      end

      # Class-level attributes that should be rendered as XML attributes
      # @return [Array<String>] attribute names
      def attributes
        []
      end

      # XML namespace for this type
      # @return [String] namespace URI
      def namespace
        DEFAULT_NAMESPACE
      end
    end

    # Instance-level attributes for XML serialization
    # @return [Hash] attribute hash for XML attributes
    def attributes
      self.class.attributes.map do |attribute|
        value = self[attribute]
        next unless value

        property_name = self.class.inverse_translations.fetch(attribute, attribute)
        [property_name, build_value(value)]
      end.compact.to_h
    end

    # Build XML representation of this object
    # @param builder [Nokogiri::XML::Builder] XML builder object
    # @param namespace [String, nil] XML namespace prefix
    # @return [void]
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

    # XML namespace definitions for this object
    # @return [Hash] namespace definitions hash
    def namespace_definitions
      DEFAULT_NAMESPACE_DEFINITIONS
    end

    # Inverted namespace definitions for reverse lookups
    # @return [Hash] inverted namespace definitions
    def inverted_namespace_definitions
      @inverted_namespace_definitions ||= if namespace_definitions == DEFAULT_NAMESPACE_DEFINITIONS
                                            INVERTED_DEFAULT_NAMESPACE_DEFINITIONS
                                          else
                                            namespace_definitions.invert
                                          end
    end

    private

    # Build an XML element for a nested object
    # @param builder [Nokogiri::XML::Builder] XML builder object
    # @param property_name [String] XML element name
    # @param element [Base] TCX object to serialize
    # @return [void]
    def build_el(builder, property_name, element)
      attributes = element.attributes if element.is_a?(Base)
      namespace = inverted_namespace_definitions[element.class.namespace]&.split(':')&.[](1) if element.is_a?(Base)
      builder = builder[namespace] if namespace

      builder.send(property_name, attributes) do |property_builder|
        element.build_xml(property_builder, namespace)
      end
    end

    # Build an XML value from a Ruby value
    # @param value [Object] Ruby value to convert
    # @return [String, nil] XML-safe value
    def build_value(value)
      case value
      when Nokogiri::XML::Element
        # empty node
      when ::Time
        value.iso8601
      else
        value
      end
    end
  end
end
