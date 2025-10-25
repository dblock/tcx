# frozen_string_literal: true

module Tcx
  class Database < Base
    property 'folders', from: 'Folders', transform_with: ->(arr) { Folders.parse(arr) }
    property 'activities', from: 'Activities', transform_with: ->(arr) { ActivityList.parse(arr) }
    property 'workouts', from: 'Workouts', transform_with: ->(arr) { WorkoutList.parse(arr) }
    property 'courses', from: 'Courses', transform_with: ->(arr) { CourseList.parse(arr) }
    property 'author', from: 'Author', transform_with: ->(el) { AbstractSource.parse(el) }

    attr_accessor :namespace_definitions

    class << self
      def load(data)
        xml = Nokogiri::XML(data)
        parse(xml.root)
      end

      def parse(xml)
        instance = super
        instance.namespace_definitions = {
          'xsi:schemaLocation' => xml['xsi:schemaLocation']
        }.merge(xml.namespace_definitions.to_h do |ns|
          [['xmlns', ns.prefix].compact.join(':'), ns.href]
        end)
        instance
      end
    end

    def dump(target_path)
      ::File.write(target_path, to_xml)
    end

    def to_xml
      to_xml_builder.to_xml
    end

    private

    def to_xml_builder
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.TrainingCenterDatabase(namespace_definitions) do |xml|
          build_xml(xml)
        end
      end
    end
  end
end
