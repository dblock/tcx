# frozen_string_literal: true

module Tcx
  # Activity_t
  #
  # Represents a single completed workout or training session.
  # An activity consists of one or more laps, each containing detailed tracking data.
  #
  # Common activity types include running, cycling, swimming, hiking, and other sports.
  # Each activity is uniquely identified by its start timestamp and associated with a specific sport type.
  #
  # XSD Definition:
  #   - Id (dateTime): Unique identifier timestamp (usually start time)
  #   - Lap (ActivityLap_t): One or more laps (1..unbounded)
  #   - Notes (string): Optional activity notes
  #   - Training (Training_t): Optional training context
  #   - Creator (AbstractSource_t): Optional device/application that recorded the activity
  #   - Extensions (Extensions_t): Optional extension data
  #   - Sport (attribute, Sport_t): The type of sport (Running, Biking, etc.)
  #
  # @example
  #   activity = Activity.new('Sport' => 'Running', 'Id' => '2024-06-15T08:00:00Z')
  #   puts "Total distance: #{activity.distance_meters}m"
  #   puts "Average heart rate: #{activity.average_heart_rate_bpm} bpm"
  class Activity < Base
    # The sport type for this activity (Running, Biking, etc.)
    # @return [Sport] the sport enumeration value
    property 'sport', from: 'Sport', transform_with: ->(v) { Sport.parse(v) }

    # Unique identifier timestamp (typically the activity start time)
    # @return [String] ISO 8601 dateTime string
    property 'id', from: 'Id'

    # Collection of laps that make up this activity
    # @return [Array<Lap>] array of lap objects (at least one)
    property 'laps', from: 'Lap', transform_with: ->(v) { to_array(v).map { |el| Lap.parse(el) } }

    # Optional notes or description of the activity
    # @return [String, nil] notes text or nil
    property 'notes', from: 'Notes'

    # Optional training context (planned workout reference, virtual partner, etc.)
    # @return [Array<Training>] array of training objects
    property 'training', from: 'Training', transform_with: ->(v) { to_array(v).map { |el| Training.parse(el) } }

    # Device or application that created/recorded this activity
    # @return [AbstractSource, nil] creator object (Device_t or Application_t)
    property 'creator', from: 'Creator', transform_with: ->(v) { AbstractSource.parse(v) }

    # Optional extension data for custom fields
    # @return [ExtensionsList, nil] extensions object
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    # Calculate total duration across all laps
    # @return [Float, nil] total time in seconds or nil if not available
    def total_time_seconds
      laps&.map(&:total_time_seconds)&.compact&.sum
    end

    # Get the activity start time (from first lap)
    # @return [Time, nil] start timestamp or nil
    def start_time
      laps&.first&.start_time
    end

    # Get the activity end time (from last lap)
    # @return [Time, nil] end timestamp or nil
    def end_time
      laps&.last&.end_time
    end

    # Calculate total distance across all laps
    # @return [Float, nil] total distance in meters or nil
    def distance_meters
      laps&.map(&:distance_meters)&.compact&.sum
    end

    # Find maximum speed across all laps
    # @return [Float, nil] maximum speed in meters/second or nil
    def maximum_speed
      laps&.map(&:maximum_speed)&.compact&.max
    end

    # Calculate total calories burned across all laps
    # @return [Integer, nil] total calories or nil
    def calories
      laps&.map(&:calories)&.compact&.sum
    end

    # Calculate weighted average heart rate across all laps
    # Weights each lap's average by the number of tracks it contains
    # @return [Float, nil] weighted average heart rate in BPM or nil
    def average_heart_rate_bpm
      total = laps&.map { |lap| lap&.tracks&.size }&.compact&.sum

      laps&.map do |lap|
        next unless lap.tracks&.any? && !lap.average_heart_rate_bpm.nil? && !lap.average_heart_rate_bpm.value.nil?

        (lap.tracks.size.to_f / total) * lap.average_heart_rate_bpm&.to_i
      end&.compact&.sum
    end

    # Find maximum heart rate across all laps
    # @return [Integer, nil] maximum heart rate in BPM or nil
    def maximum_heart_rate_bpm
      laps&.map { |lap| lap.maximum_heart_rate_bpm&.to_i }&.compact&.max
    end

    # Calculate average pace (speed) for the activity
    # @return [Float, nil] average speed in meters/second, 0 if no time, or nil
    def average_pace
      tts = total_time_seconds
      ldm = distance_meters

      return if ldm.nil? || tts.nil?
      return 0 if tts.zero?

      ldm.to_f / tts
    end

    # Extension methods for Activity Lap Extension (LX) data

    # Find maximum bike cadence from lap extensions
    # @return [Integer, nil] maximum bike cadence in RPM or nil
    def max_bike_cadence
      laps&.map { |lap| lap&.max_bike_cadence&.to_i }&.compact&.max
    end

    # Find maximum run cadence from lap extensions
    # @return [Integer, nil] maximum run cadence in SPM or nil
    def max_run_cadence
      laps&.map { |lap| lap&.max_run_cadence&.to_i }&.compact&.max
    end

    # Calculate total steps from lap extensions
    # @return [Integer, nil] total step count or nil
    def steps
      laps&.map { |lap| lap&.steps&.to_i }&.compact&.sum
    end

    # Find maximum power output from lap extensions
    # @return [Integer, nil] maximum power in watts or nil
    def max_watts
      laps&.map { |lap| lap&.max_watts&.to_i }&.compact&.max
    end

    # Define which properties should be rendered as XML attributes
    # @return [Array<String>] list of attribute property names
    def self.attributes
      ['sport']
    end
  end
end
