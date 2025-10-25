# frozen_string_literal: true

module Tcx
  module Types
    # Folders_t
    #
    # Top-level organizational structure for categorizing TCX data.
    # Contains three main folder hierarchies for different types of data:
    # - History: Past completed activities organized by sport type
    # - Courses: Saved GPS routes and courses
    # - Workouts: Planned workout definitions
    #
    # This allows users to organize their training data hierarchically,
    # similar to file system folders.
    #
    # XSD Definition:
    #   - History (History_t): Activity history folders (optional)
    #   - Workouts (Workouts_t): Workout folders (optional)
    #   - Courses (Courses_t): Course folders (optional)
    #
    # @example
    #   folders.history.running  # => HistoryFolder with running activities
    #   folders.workouts.running  # => WorkoutFolder with running workouts
    class Folders < Base
      # Activity history organization by sport (Running, Biking, Other, MultiSport)
      # @return [Array<History>] array of history objects
      property 'history', from: 'History', transform_with: ->(v) { to_array(v).map { |el| History.parse(el) } }

      # Course/route folder organization
      # @return [Array<Courses>] array of course folder structures
      property 'courses', from: 'Courses', transform_with: ->(v) { to_array(v).map { |el| Courses.parse(el) } }

      # Planned workout folder organization
      # @return [Array<Workouts>] array of workout folder structures
      property 'workouts', from: 'Workouts', transform_with: ->(v) { to_array(v).map { |el| Workouts.parse(el) } }
    end
  end
end
