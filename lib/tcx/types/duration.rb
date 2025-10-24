# frozen_string_literal: true

module Tcx
  class Duration < Base
    property 'seconds', from: 'Seconds', transform_with: lambda(&:to_i)
    property 'meters', from: 'Meters', transform_with: lambda(&:to_i)
    property 'heart_rate', from: 'HeartRate', transform_with: ->(v) { HeartRateValue.parse(v) }
    property 'calories', from: 'Calories', transform_with: lambda(&:to_i)
  end
end
