# frozen_string_literal: true

module Tcx
  class CourseList < Base
    property 'courses', from: 'Courses', transform_with: ->(v) { v.map { |el| Course.parse(el) } }

    def_delegators :courses, :each, :to_a

    def self.parse(list)
      CourseList.new('Courses' => list.xpath('xmlns:Course'))
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
