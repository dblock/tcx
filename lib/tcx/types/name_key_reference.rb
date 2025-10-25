# frozen_string_literal: true

module Tcx
  # NameKeyReference_t
  #
  # A reference to a named entity (workout or course) using its name as the unique key.
  # Used in folder structures to link to workouts or courses by name.
  #
  # Unlike ActivityReference (which uses timestamps), NameKeyReference uses string names
  # to identify workouts and courses.
  #
  # XSD Definition:
  #   - Id (Token): Entity name (unique identifier)
  #   - Name (Token): Optional display name (typically same as Id)
  #
  # @example Reference to a workout by name
  #   ref = NameKeyReference.new(
  #     'Id' => '5x1K_Intervals',
  #     'Name' => '5x1K Intervals'
  #   )
  #
  # @see WorkoutFolder
  # @see CourseFolder
  # @see Workout
  # @see Course
  class NameKeyReference < Base
    # Entity name (unique identifier)
    # @return [String] entity ID/name
    property 'id', from: 'Id'

    # Optional display name
    # @return [String, nil] display name or nil
    property 'name', from: 'Name'
  end
end
