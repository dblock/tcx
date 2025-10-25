# frozen_string_literal: true

module Tcx
  # Trackpoint_t
  #
  # Represents a single data point in a GPS track, capturing sensor readings at a specific
  # moment in time. Trackpoints are the fundamental unit of detailed activity tracking,
  # containing position, altitude, heart rate, cadence, and other sensor data.
  #
  # Trackpoints are collected at regular intervals (typically 1-5 seconds) during an activity
  # and stored within Track objects.
  #
  # XSD Definition:
  #   - Time (dateTime): Timestamp of this data point
  #   - Position (Position_t): GPS coordinates (latitude/longitude)
  #   - AltitudeMeters (double): Elevation in meters
  #   - DistanceMeters (double): Cumulative distance from activity start
  #   - HeartRateBpm (HeartRateInBeatsPerMinute_t): Heart rate reading
  #   - Cadence (unsignedByte): Cadence (RPM for bike, SPM for run)
  #   - SensorState (SensorState_t): Sensor connection status (Present/Absent)
  #   - Extensions (Extensions_t): Optional TPX data (speed, watts, run cadence)
  #
  # @example
  #   trackpoint = Trackpoint.new(
  #     'Time' => '2024-06-15T08:00:30Z',
  #     'Position' => { 'LatitudeDegrees' => 40.7128, 'LongitudeDegrees' => -74.0060 },
  #     'AltitudeMeters' => 10.5,
  #     'DistanceMeters' => 150.0,
  #     'HeartRateBpm' => { 'Value' => 145 }
  #   )
  class Trackpoint < Base
    # Timestamp when this data point was recorded
    # @return [Time] recording timestamp
    property 'time', from: 'Time', transform_with: ->(v) { ::Time.parse(v) }

    # GPS coordinates (latitude and longitude)
    # @return [Position, nil] position object or nil if GPS unavailable
    property 'position', from: 'Position', transform_with: ->(v) { Position.parse(v) }

    # Elevation/altitude reading
    # @return [Float, nil] altitude in meters or nil
    property 'altitude_meters', from: 'AltitudeMeters', transform_with: lambda(&:to_f)

    # Cumulative distance from the start of the activity
    # @return [Float, nil] distance in meters or nil
    property 'distance_meters', from: 'DistanceMeters', transform_with: lambda(&:to_f)

    # Heart rate measurement at this point
    # @return [HeartRateInBeatsPerMinute, nil] HR object or nil
    property 'heart_rate_bpm', from: 'HeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }

    # Cadence measurement (RPM for cycling, SPM for running)
    # @return [Cadence, nil] cadence object or nil
    property 'cadence', from: 'Cadence', transform_with: ->(v) { Cadence.parse(v) }

    # Status of the heart rate sensor connection
    # @return [SensorState, nil] sensor state (Present/Absent) or nil
    property 'sensor_state', from: 'SensorState', transform_with: ->(v) { SensorState.parse(v) }

    # Optional extension data (TPX for speed, watts, run cadence)
    # @return [ExtensionsList, nil] extensions object or nil
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
  end
end
