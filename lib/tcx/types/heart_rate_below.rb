# frozen_string_literal: true

module Tcx
  # HeartRateBelow_t (extends Duration_t)
  #
  # Workout step duration that continues until heart rate drops below a threshold.
  # Used for recovery intervals or cool-down periods.
  #
  # For example: "Continue recovery until HR drops below 120 BPM"
  #
  # XSD Definition:
  #   - HeartRate (HeartRateValue_t): The threshold heart rate value
  #
  # @example Recovery until HR below 130
  #   duration = HeartRateBelow.new('HeartRate' => {
  #     'HeartRateInBeatsPerMinute' => { 'Value' => 130 }
  #   })
  #
  # @see Duration
  # @see HeartRateAbove
  class HeartRateBelow < Duration
    # The heart rate threshold value to drop below
    # @return [HeartRateValue] threshold heart rate
    property 'heart_rate', from: 'HeartRate', transform_with: ->(v) { HeartRateValue.parse(v) }
  end
end
