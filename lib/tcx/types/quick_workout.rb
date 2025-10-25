# frozen_string_literal: true

module Tcx
  module Types
    # QuickWorkout_t
    #
    # Results from an ad-hoc workout created on a GPS device (not a pre-planned workout).
    # Quick workouts allow users to start a simple structured workout directly on their device
    # without syncing from training software.
    #
    # This type stores basic summary information about the quick workout that was performed:
    # the total time duration and total distance covered.
    #
    # XSD Definition:
    #   - TotalTimeSeconds (double): Total workout duration in seconds
    #   - DistanceMeters (double): Total distance covered in meters
    #
    # @example 30-minute 5K quick workout
    #   quick_workout = QuickWorkout.new(
    #     'TotalTimeSeconds' => 1800.0,
    #     'DistanceMeters' => 5000.0
    #   )
    #
    # @see Training
    # @see Workout
    class QuickWorkout < Base
      include Mixins::DistanceMeters

      # Total workout duration in seconds
      # @return [Float] duration in seconds
      property 'total_time_seconds', from: 'TotalTimeSeconds', transform_with: lambda(&:to_f)

      # Total distance covered in meters
      # @return [Float] distance in meters
      property 'distance_meters', from: 'DistanceMeters', transform_with: lambda(&:to_f)
    end
  end
end
