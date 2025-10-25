# frozen_string_literal: true

module Tcx
  # HeartRateAsPercentOfMax_t
  #
  # Represents heart rate as a percentage of maximum heart rate (% of max HR).
  # Used in workout targets and zones to specify intensity levels relative to
  # an athlete's maximum heart rate.
  #
  # For example, 85% of max HR for threshold training, or 60-70% for easy aerobic work.
  #
  # XSD Definition:
  #   - Value (PercentOfMax_t): Percentage value (typically 0-100)
  #
  # @example Threshold training at 85% max HR
  #   hr = HeartRateAsPercentOfMax.new('Value' => 85)
  #   hr.value  # => 85 (represents 85% of max HR)
  class HeartRateAsPercentOfMax < Base
    # Percentage of maximum heart rate
    # @return [Integer] percentage value (0-100+)
    property 'value', from: 'Value', transform_with: lambda(&:to_i)

    # Delegate numeric operations to the value
    def_delegators :value, :to_i, :==
  end
end
