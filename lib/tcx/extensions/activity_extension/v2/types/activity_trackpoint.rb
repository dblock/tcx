# frozen_string_literal: true

module Tcx
  module Extensions
    module ActivityExtension
      module V2
        module Types
          # ActivityTrackpointExtension_t (TPX)
          #
          # Garmin's Activity Extension v2 for trackpoint-level data. Provides additional
          # sensor readings beyond the standard TCX schema, including speed, run cadence,
          # and power (watts).
          #
          # This extension is accessed via trackpoint.extensions.TPX in the API.
          #
          # Namespace: http://www.garmin.com/xmlschemas/ActivityExtension/v2
          #
          # @example Accessing trackpoint extensions
          #   trackpoint = activity.laps.first.tracks.first.trackpoints.first
          #   puts "Speed: #{trackpoint.extensions.TPX.speed} m/s"
          #   puts "Run cadence: #{trackpoint.extensions.TPX.run_cadence} steps/min"
          #   puts "Power: #{trackpoint.extensions.TPX.watts}W"
          #
          # @see Tcx::Types::Trackpoint
          # @see Tcx::Types::ExtensionsList
          class ActivityTrackpoint < Base
            # Instantaneous speed in meters per second
            # @return [Float, nil] speed in m/s or nil
            property 'speed', from: 'Speed', transform_with: lambda(&:to_f)

            # Running cadence in steps per minute
            # @return [Integer, nil] cadence in steps/min or nil
            property 'run_cadence', from: 'RunCadence', transform_with: lambda(&:to_i)

            # Power output in watts (typically from cycling power meter)
            # @return [Integer, nil] power in watts or nil
            property 'watts', from: 'Watts', transform_with: lambda(&:to_i)

            # Nested extensions for further vendor-specific data
            # @return [ExtensionsList, nil] extensions or nil
            property 'extensions', from: 'Extensions', transform_with: ->(v) { Tcx::Types::ExtensionsList.parse(v) }

            # Cadence sensor type (footpod or bike)
            # Stored as XML attribute
            # @return [CadenceSensorType, nil] sensor type or nil
            property 'cadence_sensor', from: 'CadenceSensor', transform_with: ->(v) { CadenceSensorType.parse(v) }

            # XML attributes for this type
            # @return [Array<String>] attribute names
            def self.attributes
              ['cadence_sensor']
            end
          end
        end
      end
    end
  end
end
