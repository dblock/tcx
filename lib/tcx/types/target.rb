# frozen_string_literal: true

module Tcx
  module Types
    # Target_t (abstract base class)
    #
    # Defines the intensity target for a workout step. Specifies what metric to maintain
    # during the step (heart rate, pace, cadence, or power).
    #
    # This is a choice type - only ONE of these properties will be present in a workout step:
    #   - HeartRateZone: Target HR zone (e.g., Zone 3 or 140-160 BPM)
    #   - SpeedZone: Target pace zone (e.g., 8:00-9:00 min/mile)
    #   - Cadence: Target cadence (e.g., 90 RPM for running, 80 RPM for cycling)
    #   - PowerZone: Target power zone (e.g., 200-250 watts for cycling)
    #
    # XSD Definition:
    #   - HeartRateZone (Zone_t): Heart rate zone specification
    #   - SpeedZone (Zone_t): Speed/pace zone specification
    #   - Cadence (unsignedByte): Target cadence value
    #   - PowerZone (Zone_t): Power zone specification
    #
    # @example Target HR zone 3
    #   target = Target.new('HeartRateZone' => { 'Number' => 3 })
    #
    # @example Target pace 7:30-8:00 min/mile
    #   target = Target.new('SpeedZone' => { 'Low' => 3.35, 'High' => 3.58 }) # m/s
    #
    # @see Step
    # @see Zone
    # @see HeartRate
    class Target < Base
      # Target heart rate zone (custom or predefined)
      # @return [Zone, nil] HR zone or nil if using different target type
      property 'heart_rate_zone', from: 'HeartRateZone', transform_with: ->(v) { HeartRateZone.parse(v) }

      # Target speed/pace zone (custom or predefined)
      # @return [Zone, nil] speed zone or nil if using different target type
      property 'speed_zone', from: 'SpeedZone', transform_with: ->(v) { SpeedZone.parse(v) }

      # Target cadence (steps/min for running, RPM for cycling)
      # @return [Cadence, nil] cadence value or nil if using different target type
      property 'cadence', from: 'Cadence', transform_with: ->(v) { Cadence.parse(v) }

      # Target power zone (watts for cycling)
      # @return [Zone, nil] power zone or nil if using different target type
      property 'power_zone', from: 'PowerZone', transform_with: ->(v) { PowerZone.parse(v) }
    end
  end
end
