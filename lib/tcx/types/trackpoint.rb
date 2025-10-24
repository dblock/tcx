# frozen_string_literal: true

module Tcx
  class Trackpoint < Base
    property 'time', from: 'Time', transform_with: ->(v) { Time.parse(v) }
    property 'position', from: 'Position', transform_with: ->(v) { Position.parse(v) }
    property 'altitude_meters', from: 'AltitudeMeters', transform_with: lambda(&:to_f)
    property 'distance_meters', from: 'DistanceMeters', transform_with: lambda(&:to_f)
    property 'heart_rate_bpm', from: 'HeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }
    property 'cadence', from: 'Cadence', transform_with: ->(v) { Cadence.parse(v) }
    property 'sensor_state', from: 'SensorState', transform_with: ->(v) { SensorState.parse(v) }
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
    # TODO: Extensions/TPX/Speed
  end
end
