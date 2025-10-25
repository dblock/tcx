# frozen_string_literal: true

module Tcx
  # DistanceMeters
  #
  # Mixin module that provides distance unit conversion methods for any class
  # with a `distance_meters` property.
  #
  # This module adds convenience methods to convert distances from meters to
  # various other units (feet, miles, yards, kilometers) and format them as strings.
  #
  # @example Using distance conversion methods
  #   lap = Lap.new('DistanceMeters' => 5000.0)
  #   lap.distance_meters      # => 5000.0
  #   lap.distance_kilometers  # => 5.0
  #   lap.distance_miles       # => 3.10686
  #   lap.distance_miles_s     # => "3.11mi"
  #
  # @see Activity
  # @see Lap
  # @see CourseLap
  # @see Trackpoint
  # @see QuickWorkout
  module DistanceMeters
    # Convert distance to feet
    # @return [Float] distance in feet
    def distance_feet
      distance_meters * 3.28084
    end

    # Convert distance to miles
    # @return [Float] distance in miles
    def distance_miles
      distance_meters * 0.00062137
    end

    # Format distance as miles string
    # @return [String, nil] formatted distance (e.g., "3.11mi") or nil if zero/negative
    def distance_miles_s
      return unless distance_meters&.positive?

      format('%gmi', format('%.2f', distance_miles))
    end

    # Convert distance to yards
    # @return [Float] distance in yards
    def distance_yards
      distance_meters * 1.09361
    end

    # Format distance as yards string
    # @return [String, nil] formatted distance (e.g., "5468yd") or nil if zero/negative
    def distance_yards_s
      return unless distance_meters&.positive?

      format('%gyd', format('%.1f', distance_yards))
    end

    # Format distance as meters string
    # @return [String, nil] formatted distance (e.g., "5000m") or nil if zero/negative
    def distance_meters_s
      return unless distance_meters&.positive?

      format('%gm', format('%d', distance_meters))
    end

    # Convert distance to kilometers
    # @return [Float] distance in kilometers
    def distance_kilometers
      distance_meters / 1000
    end

    # Format distance as kilometers string
    # @return [String, nil] formatted distance (e.g., "5km") or nil if zero/negative
    def distance_kilometers_s
      return unless distance_meters&.positive?

      format('%gkm', format('%.2f', distance_kilometers))
    end

    # Default formatted distance (same as distance_kilometers_s)
    # @return [String, nil] formatted distance in kilometers or nil if zero/negative
    def distance_s
      distance_kilometers_s
    end
  end
end
