# frozen_string_literal: true

module Tcx
  class CoursePoint < Base
    property 'name', from: 'Name'
    property 'time', from: 'Time', transform_with: ->(v) { ::Time.parse(v) }
    property 'position', from: 'Position', transform_with: ->(v) { Position.parse(v) }
    property 'altitude_meters', from: 'AltitudeMeters', transform_with: lambda(&:to_f)
    property 'point_type', from: 'PointType', transform_with: ->(v) { CoursePointType.parse(v) }
    property 'notes', from: 'Notes'
  end
end
