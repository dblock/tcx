# frozen_string_literal: true

module Tcx
  # Extensions_t
  #
  # Container for vendor-specific extensions to the TCX format. Extensions allow
  # manufacturers and applications to include additional data beyond the standard TCX schema.
  #
  # Common extensions:
  #   - TPX (ActivityTrackpointExtension): Extra trackpoint data (speed, run cadence, watts)
  #   - LX (ActivityLapExtension): Extra lap data (avg speed, max bike cadence, steps)
  #
  # Extensions are namespaced by vendor/version to avoid conflicts. Garmin's Activity
  # Extension v2 is the most widely used extension schema.
  #
  # @example Accessing trackpoint extensions
  #   trackpoint = activity.laps.first.tracks.first.trackpoints.first
  #   speed = trackpoint.extensions&.TPX&.speed  # Speed in m/s
  #   watts = trackpoint.extensions&.TPX&.watts  # Power in watts
  #
  # @example Accessing lap extensions
  #   lap = activity.laps.first
  #   avg_speed = lap.extensions&.LX&.avg_speed  # Average speed in m/s
  #   steps = lap.extensions&.LX&.steps          # Step count
  #
  # @see Trackpoint
  # @see Lap
  # @see Activity
  class ExtensionsList < Base
    # TODO: forward all extension properties up

    # Trackpoint extension (TPX) - ActivityTrackpointExtension_t
    # @return [ActivityTrackpoint, nil] trackpoint extensions or nil
    property 'TPX', transform_with: ->(v) { Tcx::Extensions::ActivityExtension::V2::ActivityTrackpoint.parse(v) }

    # Lap extension (LX) - ActivityLapExtension_t
    # @return [ActivityLap, nil] lap extensions or nil
    property 'LX', transform_with: ->(v) { Tcx::Extensions::ActivityExtension::V2::ActivityLap.parse(v) }
  end
end
