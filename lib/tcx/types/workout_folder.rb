# frozen_string_literal: true

module Tcx
  class WorkoutFolder < Base
    property 'name', from: 'Name'
    property 'folders', from: 'Folders', transform_with: ->(v) { v.map { |el| WorkoutFolder.parse(el) } }
    property 'workout_name_ref', from: 'WorkoutNameRef', transform_with: ->(v) { NameKeyReference.parse(v) }
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    def self.parse(list)
      WorkoutFolder.new('Folders' => list.xpath('xmlns:Folder'))
    end

    def build_xml(builder, namespace = nil)
      courses.each do |course|
        builder.Course do |course_builder|
          course.build_xml(course_builder, namespace)
        end
      end
    end
  end
end
