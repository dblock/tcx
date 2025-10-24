# frozen_string_literal: true

module Tcx
  class CourseLap < Base
    property 'total_time_seconds', from: 'TotalTimeSeconds', transform_with: lambda(&:to_f)
    property 'distance_meters', from: 'DistanceMeters', transform_with: lambda(&:to_f)
    property 'begin_position', from: 'BeginPosition', transform_with: ->(v) { Position.parse(v) }
    property 'begin_altitude_meters', from: 'BeginAltitudeMeters', transform_with: lambda(&:to_f)
    property 'end_position', from: 'EndPosition', transform_with: ->(v) { Position.parse(v) }
    property 'end_altitude_meters', from: 'EndAltitudeMeters', transform_with: lambda(&:to_f)
    property 'average_heart_rate_bpm', from: 'AverageHeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }
    property 'maximum_heart_rate_bpm', from: 'MaximumHeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }
    property 'intensity', from: 'Intensity', transform_with: ->(v) { Intensity.parse(v) }
    property 'cadence', from: 'Cadence', transform_with: ->(v) { Cadence.parse(v) }
  end
end
