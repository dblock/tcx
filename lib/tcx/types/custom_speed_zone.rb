# frozen_string_literal: true

module Tcx
  class CustomSpeedZone < Zone
    property 'view_as', from: 'ViewAs', transform_with: ->(v) { SpeedType.parse(v) }
    property 'low_in_meters_per_second', from: 'LowInMetersPerSecond', transform_with: lambda(&:to_f)
    property 'high_in_meters_per_second', from: 'HighInMetersPerSecond', transform_with: lambda(&:to_f)
  end
end
