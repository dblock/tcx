# frozen_string_literal: true

module Tcx
  # HeartRateValue_t (choice type)
  #
  # Polymorphic heart rate value that can be expressed in multiple ways.
  # This is a choice type in XML Schema, meaning only ONE of these will be present.
  #
  # The different representations allow for flexible heart rate specification:
  #   - Absolute BPM value
  #   - Percentage of max HR
  #   - Threshold values (above/below a certain BPM)
  #
  # XSD Definition (choice of):
  #   - HeartRateAbove: Threshold above a BPM value
  #   - HeartRateBelow: Threshold below a BPM value
  #   - HeartRateInBeatsPerMinute: Absolute BPM value
  #   - HeartRateAsPercentOfMax: Percentage of maximum HR
  #
  # @example Different heart rate specifications
  #   # Absolute value
  #   hr = HeartRateValue.new('HeartRateInBeatsPerMinute' => { 'Value' => 145 })
  #   # Percentage
  #   hr = HeartRateValue.new('HeartRateAsPercentOfMax' => { 'Value' => 85 })
  class HeartRateValue < Base
    # Heart rate above a threshold value (for workout targets)
    # @return [HeartRateInBeatsPerMinute, nil] threshold value or nil
    property 'heart_rate_above', from: 'HeartRateAbove', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }

    # Heart rate below a threshold value (for workout targets)
    # @return [HeartRateInBeatsPerMinute, nil] threshold value or nil
    property 'heart_rate_below', from: 'HeartRateBelow', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }

    # Absolute heart rate in BPM
    # @return [HeartRateInBeatsPerMinute, nil] BPM value or nil
    property 'heart_rate_in_beats_per_minute', from: 'HeartRateInBeatsPerMinute', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }

    # Heart rate as percentage of maximum
    # @return [HeartRateAsPercentOfMax, nil] percentage value or nil
    property 'heart_rate_as_percent_of_max', from: 'HeartRateAsPercentOfMax', transform_with: ->(v) { HeartRateAsPercentOfMax.parse(v) }
  end
end
