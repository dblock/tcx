# frozen_string_literal: true

module Tcx
  module Types
    # CourseList_t
    #
    # Container for a list of Course objects. Provides array-like access to courses
    # and handles XML parsing/building.
    #
    # This type is used within CourseFolder to store the actual course definitions,
    # separate from the folder hierarchy structure.
    #
    # @example Accessing courses in a list
    #   list = CourseList.parse(xml_node)
    #   list.courses.each do |course|
    #     puts course.name
    #   end
    #
    # @see Course
    # @see CourseFolder
    class CourseList < Base
      # Array of courses in this list
      # @return [Array<Course>] courses array
      property 'courses', from: 'Courses', transform_with: ->(v) { v.map { |el| Course.parse(el) } }

      # Delegate array methods to courses
      def_delegators :courses, :each, :to_a

      # Parse a CourseList from XML node
      # @param list [Nokogiri::XML::Node] XML node containing Course elements
      # @return [CourseList] parsed course list
      def self.parse(list)
        CourseList.new('Courses' => list.xpath('xmlns:Course'))
      end

      # Build XML representation of this course list
      # @param builder [Nokogiri::XML::Builder] XML builder object
      # @param namespace [String, nil] XML namespace
      # @return [void]
      def build_xml(builder, namespace = nil)
        courses.each do |course|
          builder.Course(course.attributes) do |course_builder|
            course.build_xml(course_builder, namespace)
          end
        end
      end
    end
  end
end
