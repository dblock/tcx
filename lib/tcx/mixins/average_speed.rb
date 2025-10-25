# frozen_string_literal: true

module Tcx
  # AverageSpeed
  #
  # Mixin module that provides speed and pace conversion methods for any class
  # with an `average_speed` property (in meters/second).
  #
  # This module adds convenience methods to convert speeds from meters/second to
  # various other units (kilometers/hour, miles/hour) and calculate pace
  # (minutes per mile, minutes per kilometer, etc.).
  #
  # @example Using speed conversion methods
  #   lap = Lap.new
  #   lap.extensions.LX.avg_speed           # => 3.5 (m/s)
  #   lap.average_speed_kilometer_per_hour_s    # => "12.6km/h"
  #   lap.average_speed_miles_per_hour_s        # => "7.8mph"
  #   lap.pace_per_kilometer_s              # => "4m46s/km"
  #   lap.pace_per_mile_s                   # => "7m38s/mi"
  #
  # @see Lap
  module AverageSpeed
    # Get average speed in meters per second
    # @return [Float, nil] speed in meters/second or nil
    # @note Always in meters per second, even in imperial splits
    def average_speed_meters_per_second
      average_speed
    end
    alias avg_speed_meters_per_second average_speed_meters_per_second

    # Format pace as minutes per mile
    # @return [String, nil] formatted pace (e.g., "7m38s/mi") or nil if zero/negative
    def pace_per_mile_s
      convert_meters_per_second_to_pace average_speed, :mi
    end

    # Format pace as minutes per 100 yards
    # @return [String, nil] formatted pace (e.g., "1m30s/100yd") or nil if zero/negative
    def pace_per_100_yards_s
      convert_meters_per_second_to_pace average_speed, :'100yd'
    end

    # Format pace as minutes per 100 meters
    # @return [String, nil] formatted pace (e.g., "1m25s/100m") or nil if zero/negative
    def pace_per_100_meters_s
      convert_meters_per_second_to_pace average_speed, :'100m'
    end

    # Format pace as minutes per kilometer
    # @return [String, nil] formatted pace (e.g., "4m46s/km") or nil if zero/negative
    def pace_per_kilometer_s
      convert_meters_per_second_to_pace average_speed, :km
    end

    # Format speed as kilometers per hour
    # @return [String, nil] formatted speed (e.g., "12.6km/h") or nil if zero/negative
    def average_speed_kilometer_per_hour_s
      return unless average_speed&.positive?

      format('%.1fkm/h', average_speed * 3.6)
    end
    alias avg_speed_kilometer_per_hour_s average_speed_kilometer_per_hour_s

    # Format speed as miles per hour
    # @return [String, nil] formatted speed (e.g., "7.8mph") or nil if zero/negative
    def average_speed_miles_per_hour_s
      return unless average_speed&.positive?

      format('%.1fmph', average_speed * 2.23694)
    end
    alias avg_speed_miles_per_hour_s average_speed_miles_per_hour_s

    # Default formatted speed (same as average_speed_kilometer_per_hour_s)
    # @return [String, nil] formatted speed in km/h or nil if zero/negative
    def average_speed_s
      average_speed_kilometer_per_hour_s
    end
    alias avg_speed_s average_speed_s

    private

    # Convert speed (m/s) to pace (min/mile or min/km) in the format of 'x:xx'
    # http://yizeng.me/2017/02/25/convert-speed-to-pace-programmatically-using-ruby
    def convert_meters_per_second_to_pace(speed, unit = :mi)
      return unless speed&.positive?

      total_seconds = case unit
                      when :mi then 1609.344 / speed
                      when :km then 1000 / speed
                      when :'100yd' then 91.44 / speed
                      when :'100m' then 100 / speed
                      end
      minutes, seconds = total_seconds.divmod(60)
      seconds = seconds.round
      if seconds == 60
        minutes += 1
        seconds = 0
      end
      seconds = seconds < 10 ? "0#{seconds}" : seconds.to_s
      "#{minutes}m#{seconds}s/#{unit}"
    end
  end
end
