# frozen_string_literal: true

module Tcx
  class Lap < Base
    property 'start_time', from: 'StartTime', transform_with: ->(v) { ::Time.parse(v) }
    property 'total_time_seconds', from: 'TotalTimeSeconds', transform_with: lambda(&:to_f)
    property 'distance_meters', from: 'DistanceMeters', transform_with: lambda(&:to_f)
    property 'maximum_speed', from: 'MaximumSpeed', transform_with: lambda(&:to_f)
    property 'calories', from: 'Calories', transform_with: lambda(&:to_i)
    property 'average_heart_rate_bpm', from: 'AverageHeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }
    property 'maximum_heart_rate_bpm', from: 'MaximumHeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }
    property 'intensity', from: 'Intensity', transform_with: ->(v) { Intensity.parse(v) }
    property 'cadence', from: 'Cadence', transform_with: ->(v) { Cadence.parse(v) }
    property 'trigger_method', from: 'TriggerMethod', transform_with: ->(v) { TriggerMethod.parse(v) }
    property 'tracks', from: 'Track', transform_with: ->(v) { to_array(v).map { |el| Track.parse(el) } }
    property 'notes', from: 'Notes'
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    def self.attributes
      ['start_time']
    end
  end
end
