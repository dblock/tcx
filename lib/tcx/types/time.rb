# frozen_string_literal: true

module Tcx
  # Time_t (extends Duration_t)
  #
  # Represents a time-based duration for workout steps. Specifies that a step should
  # continue for a specific number of seconds.
  #
  # This is one of the concrete implementations of Duration_t, used when a workout
  # step has a fixed time duration (e.g., "Warm up for 10 minutes").
  #
  # XSD Definition:
  #   - Seconds (positiveInteger): Duration in seconds
  #
  # @example 10-minute warm up (600 seconds)
  #   duration = Time.new('Seconds' => 600)
  #
  # @example 30-second sprint
  #   duration = Time.new('Seconds' => 30)
  #
  # @see Duration
  # @see Step
  class Time < Base
    # Duration in seconds
    # @return [Integer] number of seconds
    property 'seconds', from: 'Seconds', transform_with: lambda(&:to_i)

    # XML attributes including xsi:type for polymorphism
    # @return [Hash] attribute hash with xsi:type
    def attributes
      super.merge('xsi:type' => 'Time_t')
    end
  end
end
