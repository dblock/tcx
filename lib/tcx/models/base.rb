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
  end
end
