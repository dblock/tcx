# frozen_string_literal: true

module Tcx
  # CourseLap_t
  #
  # Represents a lap or segment within a course route. Course laps define logical sections
  # of a course with expected performance metrics (time, heart rate, etc.).
  #
  # Unlike activity laps (which contain actual recorded data), course laps contain
  # planned or expected values for training purposes. For example, a marathon course
  # might have laps for each mile with target times and heart rates.
  #
  # XSD Definition:
  #   - TotalTimeSeconds (double): Expected duration for this segment
  #   - DistanceMeters (double): Segment distance in meters
  #   - BeginPosition (Position_t): GPS coordinates where segment starts
  #   - BeginAltitudeMeters (double): Elevation at segment start
  #   - EndPosition (Position_t): GPS coordinates where segment ends
  #   - EndAltitudeMeters (double): Elevation at segment end
  #   - AverageHeartRateBpm (HeartRateInBeatsPerMinute_t): Target average HR
  #   - MaximumHeartRateBpm (HeartRateInBeatsPerMinute_t): Expected max HR
  #   - Intensity (Intensity_t): Effort level for this segment
  #   - Cadence (unsignedByte): Target cadence
  #
  # @example 5K course lap with target metrics
  #   lap = CourseLap.new(
  #     'TotalTimeSeconds' => 1500.0,
  #     'DistanceMeters' => 5000.0,
  #     'BeginPosition' => { 'LatitudeDegrees' => 42.3601, 'LongitudeDegrees' => -71.0589 },
  #     'AverageHeartRateBpm' => { 'Value' => 150 },
  #     'Intensity' => 'Active'
  #   )
  #
  # @see Course
  # @see Lap
  class CourseLap < Base
    # Expected duration for this course segment
    # @return [Float] duration in seconds
    property 'total_time_seconds', from: 'TotalTimeSeconds', transform_with: lambda(&:to_f)

    # Segment distance in meters
    # @return [Float] distance in meters
    property 'distance_meters', from: 'DistanceMeters', transform_with: lambda(&:to_f)

    # GPS coordinates where this segment begins
    # @return [Position, nil] start position or nil
    property 'begin_position', from: 'BeginPosition', transform_with: ->(v) { Position.parse(v) }

    # Elevation at the start of this segment
    # @return [Float, nil] altitude in meters or nil
    property 'begin_altitude_meters', from: 'BeginAltitudeMeters', transform_with: lambda(&:to_f)

    # GPS coordinates where this segment ends
    # @return [Position, nil] end position or nil
    property 'end_position', from: 'EndPosition', transform_with: ->(v) { Position.parse(v) }

    # Elevation at the end of this segment
    # @return [Float, nil] altitude in meters or nil
    property 'end_altitude_meters', from: 'EndAltitudeMeters', transform_with: lambda(&:to_f)

    # Target average heart rate for this segment
    # @return [HeartRateInBeatsPerMinute, nil] average HR in BPM or nil
    property 'average_heart_rate_bpm', from: 'AverageHeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }

    # Expected maximum heart rate for this segment
    # @return [HeartRateInBeatsPerMinute, nil] max HR in BPM or nil
    property 'maximum_heart_rate_bpm', from: 'MaximumHeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }

    # Effort level for this segment
    # @return [Intensity, nil] intensity enumeration or nil
    property 'intensity', from: 'Intensity', transform_with: ->(v) { Intensity.parse(v) }

    # Target cadence for this segment
    # @return [Cadence, nil] cadence value or nil
    property 'cadence', from: 'Cadence', transform_with: ->(v) { Cadence.parse(v) }
  end
end
