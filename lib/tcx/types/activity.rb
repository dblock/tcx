# frozen_string_literal: true

module Tcx
  class Activity < Base
    property 'sport', from: 'Sport', transform_with: ->(v) { Sport.parse(v) }
    property 'id', from: 'Id'
    property 'laps', from: 'Lap', transform_with: ->(v) { to_array(v).map { |el| Lap.parse(el) } }
    property 'notes', from: 'Notes'
    property 'training', from: 'Training', transform_with: ->(v) { to_array(v).map { |el| Training.parse(el) } }
    property 'creator', from: 'Creator', transform_with: ->(v) { AbstractSource.parse(v) }
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    def total_time_seconds
      laps&.map(&:total_time_seconds)&.compact&.sum
    end

    def start_time
      laps&.first&.start_time
    end

    def end_time
      laps&.last&.end_time
    end

    def distance_meters
      laps&.map(&:distance_meters)&.compact&.sum
    end

    def maximum_speed
      laps&.map(&:maximum_speed)&.compact&.max
    end

    def calories
      laps&.map(&:calories)&.compact&.sum
    end

    # weighted average
    def average_heart_rate_bpm
      total = laps&.map { |lap| lap&.tracks&.size }&.compact&.sum

      laps&.map do |lap|
        next unless lap.tracks&.any? && !lap.average_heart_rate_bpm.nil? && !lap.average_heart_rate_bpm.value.nil?

        (lap.tracks.size.to_f / total) * lap.average_heart_rate_bpm&.to_i
      end&.compact&.sum
    end

    def maximum_heart_rate_bpm
      laps&.map { |lap| lap.maximum_heart_rate_bpm&.to_i }&.compact&.max
    end

    def average_pace
      tts = total_time_seconds
      ldm = distance_meters

      return if ldm.nil? || tts.nil?
      return 0 if tts.zero?

      ldm.to_f / tts
    end

    # LX

    def max_bike_cadence
      laps&.map { |lap| lap&.max_bike_cadence&.to_i }&.compact&.max
    end

    def max_run_cadence
      laps&.map { |lap| lap&.max_run_cadence&.to_i }&.compact&.max
    end

    def steps
      laps&.map { |lap| lap&.steps&.to_i }&.compact&.sum
    end

    def max_watts
      laps&.map { |lap| lap&.max_watts&.to_i }&.compact&.max
    end

    def self.attributes
      ['sport']
    end
  end
end
