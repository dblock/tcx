# frozen_string_literal: true

module Tcx
  module Extensions
    module ActivityExtension
      module V2
        # ActivityLapExtension_t (LX)
        #
        # Garmin's Activity Extension v2 for lap-level data. Provides additional metrics
        # beyond the standard TCX schema, including speed, cadence, power, and steps.
        #
        # This extension is accessed via lap.extensions.LX in the API.
        #
        # Namespace: http://www.garmin.com/xmlschemas/ActivityExtension/v2
        #
        # @example Accessing lap extensions
        #   lap = activity.laps.first
        #   puts "Average speed: #{lap.extensions.LX.avg_speed} m/s"
        #   puts "Steps: #{lap.extensions.LX.steps}"
        #   puts "Average power: #{lap.extensions.LX.avg_watts}W"
        #
        # @see Lap
        # @see ExtensionsList
        class ActivityLap < Base
          # Average speed for the lap in meters per second
          # @return [Float, nil] average speed in m/s or nil
          property 'avg_speed', from: 'AvgSpeed', transform_with: lambda(&:to_f)

          # Maximum cycling cadence for the lap in RPM
          # @return [Integer, nil] max bike cadence in RPM or nil
          property 'max_bike_cadence', from: 'MaxBikeCadence', transform_with: lambda(&:to_i)

          # Average running cadence for the lap in steps per minute
          # @return [Integer, nil] average run cadence in steps/min or nil
          property 'avg_run_cadence', from: 'AvgRunCadence', transform_with: lambda(&:to_i)

          # Maximum running cadence for the lap in steps per minute
          # @return [Integer, nil] max run cadence in steps/min or nil
          property 'max_run_cadence', from: 'MaxRunCadence', transform_with: lambda(&:to_i)

          # Total step count for the lap
          # @return [Integer, nil] number of steps or nil
          property 'steps', from: 'Steps', transform_with: lambda(&:to_i)

          # Average power for the lap in watts
          # @return [Integer, nil] average power in watts or nil
          property 'avg_watts', from: 'AvgWatts', transform_with: lambda(&:to_i)

          # Maximum power for the lap in watts
          # @return [Integer, nil] max power in watts or nil
          property 'max_watts', from: 'MaxWatts', transform_with: lambda(&:to_i)

          # Nested extensions for further vendor-specific data
          # @return [ExtensionsList, nil] extensions or nil
          property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
        end
      end
    end
  end
end
