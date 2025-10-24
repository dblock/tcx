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
        xml.TrainingCenterDatabase(
          'xsi:schemaLocation' => 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2 http://www.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd',
          # 'xmlns:ns5' => "http://www.garmin.com/xmlschemas/ActivityGoals/v1",
          # 'xmlns:ns3' => "http://www.garmin.com/xmlschemas/ActivityExtension/v2",
          # 'xmlns:ns2' => "http://www.garmin.com/xmlschemas/UserProfile/v2",
          'xmlns' => 'http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2',
          'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance'
          # 'xmlns:ns4' => "http://www.garmin.com/xmlschemas/ProfileExtension/v1"
        ) do |xml|
          build(xml)
        end
      end
    end
  end
end
