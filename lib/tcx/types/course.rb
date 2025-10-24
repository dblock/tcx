# frozen_string_literal: true

module Tcx
  class Course < Base
    property 'name', from: 'Name'
    property 'laps', from: 'Lap', transform_with: ->(v) { to_array(v).map { |el| CourseLap.parse(el) } }
    property 'tracks', from: 'Track', transform_with: ->(v) { to_array(v).map { |el| Track.parse(el) } }
    property 'notes', from: 'Notes'
    property 'course_points', from: 'CoursePoint', transform_with: ->(v) { to_array(v).map { |el| CoursePoint.parse(el) } }
    property 'creator', from: 'Creator', transform_with: ->(v) { AbstractSource.parse(v) }
  end
end
