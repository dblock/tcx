# frozen_string_literal: true

module Tcx
  class HeartRateValue < Base
    property 'heart_rate_above', from: 'HeartRateAbove', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }
    property 'heart_rate_below', from: 'HeartRateBelow', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }
    property 'heart_rate_in_beats_per_minute', from: 'HeartRateInBeatsPerMinute', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }
    property 'heart_rate_as_percent_of_max', from: 'HeartRateAsPercentOfMax', transform_with: ->(v) { HeartRateAsPercentOfMax.parse(v) }
  end
end
