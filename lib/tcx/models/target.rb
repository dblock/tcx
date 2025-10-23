# frozen_string_literal: true

module Tcx
  class Target < Base
    property 'heart_rate_zone', from: 'HeartRateZone', transform_with: ->(v) { HeartRateZone.parse(v) }
    property 'speed_zone', from: 'SpeedZone', transform_with: ->(v) { SpeedZone.parse(v) }
    property 'cadence', from: 'Cadence', transform_with: ->(v) { Cadence.parse(v) }
    property 'power_zone', from: 'PowerZone', transform_with: ->(v) { PowerZone.parse(v) }
  end
end
