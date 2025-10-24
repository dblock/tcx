# frozen_string_literal: true

module Tcx
  class Database < Base
    property 'folders', from: 'Folders', transform_with: ->(arr) { Folders.parse(arr) }
    property 'activities', from: 'Activities', transform_with: ->(arr) { ActivityList.parse(arr) }
    property 'workouts', from: 'Workouts', transform_with: ->(arr) { WorkoutList.parse(arr) }
    property 'courses', from: 'Courses', transform_with: ->(arr) { CourseList.parse(arr) }
    property 'author', from: 'Author', transform_with: ->(el) { AbstractSource.parse(el) }

    def self.load(data)
      parse(Nokogiri::XML(data).root)
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
        xml.TrainingCenterDatabase(Base.namespace_definitions) do |xml|
          build_xml(xml)
        end
      end
    end
  end
end
