# frozen_string_literal: true

module Tcx
  # Course_t
  #
  # Represents a predefined geographic route that can be followed during training.
  # Courses contain GPS tracks defining the route, plus waypoints (course points) marking
  # significant locations along the way.
  #
  # Courses are typically used for:
  #   - Race course reconnaissance (preview the route before race day)
  #   - Training routes (favorite running/cycling loops)
  #   - Virtual racing (follow a recorded route while competing against previous times)
  #   - Navigation (GPS guidance along a planned route)
  #
  # XSD Definition:
  #   - Name (Token): Course name/identifier
  #   - Lap (CourseLap_t): Laps/segments within the course
  #   - Track (Track_t): GPS trackpoints defining the route
  #   - Notes (Token): Optional course description or instructions
  #   - CoursePoint (CoursePoint_t): Waypoints marking key locations
  #   - Creator (AbstractSource_t): Device or app that created the course
  #
  # @example Marathon course with aid stations
  #   course = Course.new(
  #     'Name' => 'Boston Marathon 2024',
  #     'Track' => [...GPS points...],
  #     'CoursePoint' => [
  #       { 'Name' => 'Start', 'PointType' => 'Generic', 'Position' => {...} },
  #       { 'Name' => 'Water Stop', 'PointType' => 'Water', 'Position' => {...} },
  #       { 'Name' => 'Heartbreak Hill', 'PointType' => 'Summit', 'Position' => {...} }
  #     ]
  #   )
  #
  # @see CourseLap
  # @see CoursePoint
  # @see Track
  class Course < Base
    # Course name or identifier
    # @return [String] course name
    property 'name', from: 'Name'

    # Course laps or segments
    # @return [Array<CourseLap>, nil] array of laps or nil
    property 'laps', from: 'Lap', transform_with: ->(v) { to_array(v).map { |el| CourseLap.parse(el) } }

    # GPS tracks defining the route
    # @return [Array<Track>] array of tracks containing trackpoints
    property 'tracks', from: 'Track', transform_with: ->(v) { to_array(v).map { |el| Track.parse(el) } }

    # Optional course description or instructions
    # @return [String, nil] notes text or nil
    property 'notes', from: 'Notes'

    # Waypoints marking significant locations along the route
    # @return [Array<CoursePoint>, nil] array of course points or nil
    property 'course_points', from: 'CoursePoint', transform_with: ->(v) { to_array(v).map { |el| CoursePoint.parse(el) } }

    # Device or application that created this course
    # @return [AbstractSource, nil] creator information or nil
    property 'creator', from: 'Creator', transform_with: ->(v) { AbstractSource.parse(v) }
  end
end
