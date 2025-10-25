# frozen_string_literal: true

module Tcx
  class QuickWorkout < Base
    property 'total_time_seconds', from: 'TotalTimeSeconds', transform_with: lambda(&:to_f)
    property 'distance_meters', from: 'DistanceMeters', transform_with: lambda(&:to_f)
  end
end
