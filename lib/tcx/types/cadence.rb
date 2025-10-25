# frozen_string_literal: true

module Tcx
  # Cadence (simple type wrapper)
  #
  # Represents a cadence measurement (steps per minute for running, RPM for cycling).
  # Cadence is an important metric for maintaining efficient form and pacing.
  #
  # For running:
  #   - Typical cadence: 160-180 steps/minute
  #   - Elite runners: 180+ steps/minute
  #
  # For cycling:
  #   - Typical cadence: 80-100 RPM
  #   - Climbing: 60-80 RPM
  #   - Sprinting: 100+ RPM
  #
  # XSD Definition:
  #   - Value (unsignedByte): Cadence value (0-255)
  #
  # @example Running cadence of 180 steps/min
  #   cadence = Cadence.new('Value' => 180)
  #   cadence.to_i # => 180
  #
  # @see Trackpoint
  # @see Lap
  # @see CadenceTarget
  class Cadence < Base
    # Cadence value (steps/min for running, RPM for cycling)
    # @return [Integer] cadence value (0-255)
    property 'value', from: 'Value', transform_with: lambda(&:to_i)

    # Delegate to_i and == to the value for convenient comparisons
    def_delegators :value, :to_i, :==
  end
end
