# frozen_string_literal: true

module Tcx
  class Position < Base
    property 'latitude_degrees', from: 'LatitudeDegrees', transform_with: lambda(&:to_f)
    property 'longitude_degrees', from: 'LongitudeDegrees', transform_with: lambda(&:to_f)
  end
end
