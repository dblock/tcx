# frozen_string_literal: true

module Tcx
  class HeartRate < Target
    property 'heart_rate_zone', from: 'HeartRateZone', transform_with: ->(v) { Zone.parse(v) }
  end
end
