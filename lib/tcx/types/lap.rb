# frozen_string_literal: true

module Tcx
  # ActivityLap_t (also used as CourseLap_t)
  #
  # Represents a lap within an activity or course. A lap is a segment of the workout
  # with aggregated statistics (distance, time, calories, heart rate, etc.) and
  # detailed tracking data stored in one or more tracks.
  #
  # Laps can be triggered manually, by distance, by location, by time, or by heart rate.
  #
  # XSD Definition:
  #   - StartTime (attribute, dateTime): Lap start timestamp
  #   - TotalTimeSeconds (double): Duration of the lap in seconds
  #   - DistanceMeters (double): Distance covered in meters
  #   - MaximumSpeed (double): Maximum speed in meters/second
  #   - Calories (unsignedShort): Calories burned during lap
  #   - AverageHeartRateBpm (HeartRateInBeatsPerMinute_t): Average HR
  #   - MaximumHeartRateBpm (HeartRateInBeatsPerMinute_t): Maximum HR
  #   - Intensity (Intensity_t): Active or Resting
  #   - Cadence (unsignedByte): Average cadence (RPM for cycling, SPM for running)
  #   - TriggerMethod (TriggerMethod_t): How the lap was triggered
  #   - Track (Track_t): Detailed tracking data (0..unbounded)
  #   - Notes (string): Optional lap notes
  #   - Extensions (Extensions_t): Optional extension data (LX for lap metrics)
  #
  # @example
  #   lap = Lap.new('StartTime' => '2024-06-15T08:00:00Z', 'TotalTimeSeconds' => 600)
  #   puts "Lap distance: #{lap.distance_meters}m in #{lap.total_time_seconds}s"
  class Lap < Base
    # The timestamp when this lap started (stored as XML attribute)
    # @return [Time] lap start time
    property 'start_time', from: 'StartTime', transform_with: ->(v) { ::Time.parse(v) }

    # Total duration of the lap
    # @return [Float] duration in seconds
    property 'total_time_seconds', from: 'TotalTimeSeconds', transform_with: lambda(&:to_f)

    # Total distance covered during the lap
    # @return [Float] distance in meters
    property 'distance_meters', from: 'DistanceMeters', transform_with: lambda(&:to_f)

    # Maximum speed achieved during the lap
    # @return [Float] speed in meters per second
    property 'maximum_speed', from: 'MaximumSpeed', transform_with: lambda(&:to_f)

    # Total calories burned during the lap
    # @return [Integer] calorie count
    property 'calories', from: 'Calories', transform_with: lambda(&:to_i)

    # Average heart rate for the lap
    # @return [HeartRateInBeatsPerMinute] average HR object
    property 'average_heart_rate_bpm', from: 'AverageHeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }

    # Maximum heart rate for the lap
    # @return [HeartRateInBeatsPerMinute] maximum HR object
    property 'maximum_heart_rate_bpm', from: 'MaximumHeartRateBpm', transform_with: ->(v) { HeartRateInBeatsPerMinute.parse(v) }

    # Intensity level of the lap (Active or Resting)
    # @return [Intensity] intensity enumeration
    property 'intensity', from: 'Intensity', transform_with: ->(v) { Intensity.parse(v) }

    # Average cadence (RPM for cycling, SPM for running)
    # @return [Cadence] cadence object
    property 'cadence', from: 'Cadence', transform_with: ->(v) { Cadence.parse(v) }

    # How this lap was triggered (Manual, Distance, Location, Time, HeartRate)
    # @return [TriggerMethod] trigger method enumeration
    property 'trigger_method', from: 'TriggerMethod', transform_with: ->(v) { TriggerMethod.parse(v) }

    # Detailed GPS/sensor tracking data for this lap
    # @return [Array<Track>] array of track objects (may be empty)
    property 'tracks', from: 'Track', transform_with: ->(v) { to_array(v).map { |el| Track.parse(el) } }

    # Optional notes about this lap
    # @return [String, nil] notes text or nil
    property 'notes', from: 'Notes'

    # Optional extension data (LX for additional lap metrics)
    # @return [ExtensionsList, nil] extensions object or nil
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    # Calculate the end time of the lap
    # @return [Time, nil] end timestamp or nil if start_time or duration missing
    def end_time
      return if start_time.nil? || total_time_seconds.nil?

      start_time + total_time_seconds
    end

    # Define which properties should be rendered as XML attributes
    # @return [Array<String>] list of attribute property names
    def self.attributes
      ['start_time']
    end

    # Extension accessor methods for Activity Lap Extension (LX) data
    # LX provides additional metrics not in the base TCX schema

    # Average speed from lap extensions
    # @return [Float, nil] average speed in meters/second or nil
    def avg_speed
      extensions&.LX&.avg_speed
    end

    # Maximum bike cadence from lap extensions
    # @return [Integer, nil] maximum cadence in RPM or nil
    def max_bike_cadence
      extensions&.LX&.max_bike_cadence
    end

    # Average run cadence from lap extensions
    # @return [Integer, nil] average cadence in SPM or nil
    def avg_run_cadence
      extensions&.LX&.avg_run_cadence
    end

    # Maximum run cadence from lap extensions
    # @return [Integer, nil] maximum cadence in SPM or nil
    def max_run_cadence
      extensions&.LX&.max_run_cadence
    end

    # Total step count from lap extensions
    # @return [Integer, nil] step count or nil
    def steps
      extensions&.LX&.steps
    end

    # Average power output from lap extensions
    # @return [Integer, nil] average power in watts or nil
    def avg_watts
      extensions&.LX&.avg_watts
    end

    # Maximum power output from lap extensions
    # @return [Integer, nil] maximum power in watts or nil
    def max_watts
      extensions&.LX&.max_watts
    end

    # Extension accessor methods for Trackpoint Extension (TPX) data
    # Note: These are typically on trackpoints, but can be aggregated at lap level

    # Speed from trackpoint extensions
    # @return [Float, nil] speed in meters/second or nil
    def speed
      extensions&.TPX&.speed
    end

    # Run cadence from trackpoint extensions
    # @return [Integer, nil] cadence in SPM or nil
    def run_cadence
      extensions&.TPX&.run_cadence
    end

    # Power output from trackpoint extensions
    # @return [Integer, nil] power in watts or nil
    def watts
      extensions&.TPX&.watts
    end

    # Cadence sensor type from trackpoint extensions
    # @return [String, nil] sensor type (Footpod or Bike) or nil
    def cadence_sensor
      extensions&.TPX&.cadence_sensor
    end
  end
end
