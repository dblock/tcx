# frozen_string_literal: true

module Tcx
  # HeartRate_t (extends Target_t)
  #
  # Defines a heart rate zone target for workout steps.
  # Specifies that a workout step should be performed within a specific heart rate zone,
  # either predefined (zone 1-5) or custom (specific BPM range).
  #
  # XSD Definition:
  #   - HeartRateZone (Zone_t): Zone specification (custom or predefined)
  #
  # @example Custom HR zone (140-160 BPM)
  #   target = HeartRate.new('HeartRateZone' => {
  #     'Low' => 140,
  #     'High' => 160
  #   })
  #
  # @see Zone
  # @see CustomHeartRateZone
  # @see PredefinedHeartRateZone
  class HeartRate < Target
    # The heart rate zone specification (custom BPM range or predefined zone number)
    # @return [Zone] zone object (CustomHeartRateZone or PredefinedHeartRateZone)
    property 'heart_rate_zone', from: 'HeartRateZone', transform_with: ->(v) { Zone.parse(v) }
  end
end
