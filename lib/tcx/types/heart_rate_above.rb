# frozen_string_literal: true

module Tcx
  class HeartRateAbove < Duration
    property 'heart_rate', from: 'HeartRate', transform_with: ->(v) { HeartRateValue.parse(v) }
  end
end
