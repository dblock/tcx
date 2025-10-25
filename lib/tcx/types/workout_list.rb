# frozen_string_literal: true

module Tcx
  # WorkoutList_t
  #
  # Container for a list of Workout objects. Provides array-like access to workouts
  # and handles XML parsing/building.
  #
  # This type is similar to CourseList and ActivityList, providing collection semantics
  # for workout arrays within the TCX database.
  #
  # @example Accessing workouts in a list
  #   list = WorkoutList.parse(xml_node)
  #   list.workouts.each do |workout|
  #     puts workout.name
  #   end
  #
  # @see Workout
  # @see WorkoutFolder
  class WorkoutList < Base
    # Array of workouts in this list
    # @return [Array<Workout>] workouts array
    property 'workouts', from: 'Workouts', transform_with: ->(v) { v.map { |el| Workout.parse(el) } }

    # Delegate array methods to workouts
    def_delegators :workouts, :each, :count

    # Parse a WorkoutList from XML node
    # @param list [Nokogiri::XML::Node] XML node containing Workout elements
    # @return [WorkoutList] parsed workout list
    def self.parse(list)
      WorkoutList.new('Workouts' => list.xpath('xmlns:Workout'))
    end

    # Build XML representation of this workout list
    # @param builder [Nokogiri::XML::Builder] XML builder object
    # @param namespace [String, nil] XML namespace
    # @return [void]
    def build_xml(builder, namespace = nil)
      workouts.each do |workout|
        builder.Workout(workout.attributes) do |workout_builder|
          workout.build_xml(workout_builder, namespace)
        end
      end
    end
  end
end
