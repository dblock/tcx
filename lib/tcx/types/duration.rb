# frozen_string_literal: true

module Tcx
  module Types
    # Duration_t (abstract base class)
    #
    # Defines how long a workout step should last. Used in structured workouts to specify
    # when a step transitions to the next (e.g., run for 10 minutes, then run 1 mile, etc.).
    #
    # This is a choice type - only ONE of these properties will be present in a workout step:
    #   - Seconds: Time-based duration (e.g., warm up for 5 minutes)
    #   - Meters: Distance-based duration (e.g., run 1600 meters)
    #   - HeartRate: HR-based duration (e.g., until HR rises above 140 BPM)
    #   - Calories: Calorie-based duration (e.g., burn 200 calories)
    #
    # XSD Definition:
    #   - Seconds (Time): Duration in seconds
    #   - Meters (Distance): Duration in meters
    #   - HeartRate (HeartRateValue_t): HR threshold to reach
    #   - Calories (CaloriesBurned): Calories to burn
    #
    # @example 10-minute warm up
    #   duration = Duration.new('Seconds' => 600)
    #
    # @example 5K run
    #   duration = Duration.new('Meters' => 5000)
    #
    # @see Step
    # @see HeartRateAbove
    # @see HeartRateBelow
    class Duration < Base
      # Duration in seconds (time-based step)
      # @return [Integer, nil] duration in seconds or nil if using different duration type
      property 'seconds', from: 'Seconds', transform_with: lambda(&:to_i)

      # Duration in meters (distance-based step)
      # @return [Integer, nil] distance in meters or nil if using different duration type
      property 'meters', from: 'Meters', transform_with: lambda(&:to_i)

      # Heart rate threshold to reach (HR-based step)
      # @return [HeartRateValue, nil] HR value or nil if using different duration type
      property 'heart_rate', from: 'HeartRate', transform_with: ->(v) { HeartRateValue.parse(v) }

      # Calories to burn (calorie-based step)
      # @return [Integer, nil] calories to burn or nil if using different duration type
      property 'calories', from: 'Calories', transform_with: lambda(&:to_i)
    end
  end
end
