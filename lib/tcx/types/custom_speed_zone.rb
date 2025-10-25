# frozen_string_literal: true

module Tcx
  module Types
    # CustomSpeedZone_t (extends Zone_t)
    #
    # Defines a custom speed/pace zone with specific low and high boundaries.
    # Allows precise control over workout pace/speed zones beyond the standard 5-zone model.
    #
    # All speeds are stored in meters per second (m/s), but can be displayed as either
    # pace (min/mile) or speed (mph) using the ViewAs property.
    #
    # Common conversions:
    #   - 7:00 min/mile = 3.83 m/s
    #   - 8:00 min/mile = 3.35 m/s
    #   - 10 mph = 4.47 m/s
    #   - 20 mph = 8.94 m/s (cycling)
    #
    # XSD Definition:
    #   - ViewAs (SpeedType_t): How to display (Pace or Speed)
    #   - LowInMetersPerSecond (double): Lower boundary in m/s
    #   - HighInMetersPerSecond (double): Upper boundary in m/s
    #
    # @example Tempo run zone (7:00-7:30 min/mile pace)
    #   zone = CustomSpeedZone.new(
    #     'ViewAs' => 'Pace',
    #     'LowInMetersPerSecond' => 3.58, # 7:30 pace
    #     'HighInMetersPerSecond' => 3.83  # 7:00 pace (faster is higher m/s)
    #   )
    #
    # @see Zone
    # @see PredefinedSpeedZone
    # @see Speed
    class CustomSpeedZone < Zone
      # How to display this zone (Pace or Speed)
      # @return [SpeedType] display type enumeration
      property 'view_as', from: 'ViewAs', transform_with: ->(v) { SpeedType.parse(v) }

      # Lower speed boundary in meters per second
      # @return [Float] low speed value in m/s
      property 'low_in_meters_per_second', from: 'LowInMetersPerSecond', transform_with: lambda(&:to_f)

      # Upper speed boundary in meters per second
      # @return [Float] high speed value in m/s
      property 'high_in_meters_per_second', from: 'HighInMetersPerSecond', transform_with: lambda(&:to_f)
    end
  end
end
