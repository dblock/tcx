# frozen_string_literal: true

module Tcx
  module Types
    # CoursePoint_t
    #
    # Represents a waypoint or point of interest along a course route. Course points mark
    # significant locations that warrant attention during navigation or training.
    #
    # Common use cases:
    #   - Aid stations (water, food)
    #   - Turn-by-turn directions (left, right, straight)
    #   - Hazards or warnings (danger)
    #   - Terrain features (summit, valley)
    #   - Climb categories (for cycling courses)
    #   - Sprint points (for racing)
    #
    # XSD Definition:
    #   - Name (Token): Waypoint name
    #   - Time (Time): Time offset along the course
    #   - Position (Position_t): GPS coordinates of the waypoint
    #   - AltitudeMeters (double): Elevation at this point
    #   - PointType (CoursePointType_t): Type of waypoint (Water, Summit, Left, etc.)
    #   - Notes (Token): Optional waypoint description
    #
    # @example Water station at mile 5
    #   point = CoursePoint.new(
    #     'Name' => 'Water Stop',
    #     'Position' => { 'LatitudeDegrees' => 42.3601, 'LongitudeDegrees' => -71.0589 },
    #     'PointType' => 'Water',
    #     'Notes' => 'Aid station with water and sports drink'
    #   )
    #
    # @example Turn instruction
    #   point = CoursePoint.new(
    #     'Name' => 'Turn onto Main St',
    #     'Position' => { 'LatitudeDegrees' => 42.3610, 'LongitudeDegrees' => -71.0600 },
    #     'PointType' => 'Right'
    #   )
    #
    # @see Course
    # @see CoursePointType
    class CoursePoint < Base
      # Waypoint name or label
      # @return [String] point name
      property 'name', from: 'Name'

      # Time offset along the course
      # @return [Time, nil] time value or nil
      property 'time', from: 'Time', transform_with: ->(v) { ::Time.parse(v) }

      # GPS coordinates of this waypoint
      # @return [Position] position object
      property 'position', from: 'Position', transform_with: ->(v) { Position.parse(v) }

      # Elevation at this waypoint
      # @return [Float, nil] altitude in meters or nil
      property 'altitude_meters', from: 'AltitudeMeters', transform_with: lambda(&:to_f)

      # Type of waypoint (Water, Summit, Turn, etc.)
      # @return [CoursePointType] point type enumeration
      property 'point_type', from: 'PointType', transform_with: ->(v) { CoursePointType.parse(v) }

      # Optional waypoint description or instructions
      # @return [String, nil] notes text or nil
      property 'notes', from: 'Notes'
    end
  end
end
