# frozen_string_literal: true

module Tcx
  module Types
    # Speed_t (extends Target_t)
    #
    # Defines a speed/pace zone target for a workout step. Specifies that a workout step
    # should be performed within a specific speed range, either predefined (zone 1-5) or
    # custom (specific meters/second range).
    #
    # Speed can be displayed as either:
    #   - Speed: meters/second or miles/hour
    #   - Pace: minutes/mile or minutes/kilometer
    #
    # XSD Definition:
    #   - SpeedZone (Zone_t): Zone specification (custom or predefined)
    #
    # @example Custom speed zone (7:00-8:00 min/mile pace)
    #   # Convert to m/s: 7:00/mi = 3.83 m/s, 8:00/mi = 3.35 m/s
    #   target = Speed.new('SpeedZone' => {
    #     'LowInMetersPerSecond' => 3.35,
    #     'HighInMetersPerSecond' => 3.83
    #   })
    #
    # @see Target
    # @see Zone
    # @see CustomSpeedZone
    # @see PredefinedSpeedZone
    class Speed < Target
      # The speed zone specification (custom range or predefined zone number)
      # @return [Zone] zone object (CustomSpeedZone or PredefinedSpeedZone)
      property 'speed_zone', from: 'SpeedZone', transform_with: ->(v) { Zone.parse(v) }
    end
  end
end
