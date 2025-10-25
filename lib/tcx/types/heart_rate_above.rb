# frozen_string_literal: true

module Tcx
  module Types
    # HeartRateAbove_t (extends Duration_t)
    #
    # Workout step duration that continues until heart rate rises above a threshold.
    # Used for warm-up intervals or progressive intensity steps.
    #
    # For example: "Continue this step until HR exceeds 150 BPM"
    #
    # XSD Definition:
    #   - HeartRate (HeartRateValue_t): The threshold heart rate value
    #
    # @example Warm up until HR above 120
    #   duration = HeartRateAbove.new('HeartRate' => {
    #     'HeartRateInBeatsPerMinute' => { 'Value' => 120 }
    #   })
    #
    # @see Duration
    # @see HeartRateBelow
    class HeartRateAbove < Duration
      # The heart rate threshold value to exceed
      # @return [HeartRateValue] threshold heart rate
      property 'heart_rate', from: 'HeartRate', transform_with: ->(v) { HeartRateValue.parse(v) }
    end
  end
end
