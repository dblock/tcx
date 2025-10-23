# frozen_string_literal: true

module Tcx
  class CourseList < Base
    extend Forwardable

    property 'courses', from: 'Courses', transform_with: ->(v) { v.map { |el| Course.parse(el) } }

    def_delegators :courses, :each, :to_a

    def self.parse(list)
      CourseList.new('Courses' => list.xpath('xmlns:Course'))
    end

    def build(builder)
      courses.each do |course|
        builder.Course do |course_builder|
          course.build(course_builder)
        end
      end
    end
  end
end
