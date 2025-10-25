# frozen_string_literal: true

module Tcx
  # HeartRateInBeatsPerMinute_t
  #
  # Represents a heart rate measurement in beats per minute (BPM).
  # This is the most common way to express heart rate in TCX files.
  #
  # Used in trackpoints, laps, and activities to record actual heart rate readings
  # from heart rate monitors or other sensors.
  #
  # XSD Definition:
  #   - Value (unsignedByte): Heart rate value (0-255 BPM)
  #
  # @example
  #   hr = HeartRateInBeatsPerMinute.new('Value' => 145)
  #   hr.to_i  # => 145
  #   hr == 145  # => true
  class HeartRateInBeatsPerMinute < Base
    # Heart rate value in beats per minute
    # @return [Integer] BPM value (0-255)
    property 'value', from: 'Value', transform_with: lambda(&:to_i)

    # Delegate numeric operations to the value
    def_delegators :value, :to_i, :==
  end
end
