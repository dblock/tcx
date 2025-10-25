# frozen_string_literal: true

module Tcx
  # Track_t
  #
  # Represents a continuous sequence of GPS trackpoints within a lap.
  # A track contains the detailed second-by-second (or point-by-point) data collected
  # during an activity, including position, heart rate, cadence, and other sensor readings.
  #
  # Multiple tracks within a single lap can occur when GPS signal is lost and regained,
  # or when the recording is paused and resumed. Each continuous recording segment
  # becomes its own track.
  #
  # XSD Definition:
  #   - Trackpoint (Trackpoint_t): Sequence of data points (0..unbounded)
  #
  # @example
  #   track = Track.new('Trackpoint' => [
  #     { 'Time' => '2024-06-15T08:00:00Z', 'Position' => {...} },
  #     { 'Time' => '2024-06-15T08:00:05Z', 'Position' => {...} }
  #   ])
  #   puts "Track has #{track.trackpoints.length} points"
  class Track < Base
    # Ordered sequence of GPS and sensor data points
    # @return [Array<Trackpoint>] array of trackpoint objects (may be empty)
    property 'trackpoints', from: 'Trackpoint', transform_with: ->(v) { to_array(v).map { |el| Trackpoint.parse(el) } }
  end
end
