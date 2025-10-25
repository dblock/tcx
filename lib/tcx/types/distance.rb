# frozen_string_literal: true

module Tcx
  module Types
    # Distance_t (extends Duration_t)
    #
    # Represents a distance-based duration for workout steps. Specifies that a step should
    # continue for a specific distance in meters.
    #
    # This is one of the most common duration types for running and cycling workouts,
    # used when the goal is to cover a specific distance regardless of time.
    #
    # Common examples:
    #   - Track workouts: 400m, 800m, 1600m repeats
    #   - Road workouts: 5K, 10K distances
    #   - Cycling: 10 mile, 20 mile segments
    #
    # XSD Definition:
    #   - Meters (positiveInteger): Distance in meters
    #
    # @example 400-meter repeat
    #   duration = Distance.new('Meters' => 400)
    #
    # @example 5K run (5000 meters)
    #   duration = Distance.new('Meters' => 5000)
    #
    # @see Duration
    # @see Step
    class Distance < Duration
      # Distance in meters
      # @return [Integer] number of meters
      property 'meters', from: 'Meters', transform_with: lambda(&:to_i)
    end
  end
end
