# frozen_string_literal: true

module Tcx
  module Types
    # Position_t
    #
    # Represents a GPS coordinate pair (latitude and longitude) in decimal degrees.
    # Used within trackpoints and course points to record geographic location.
    #
    # Coordinates follow the WGS84 datum standard:
    #   - Latitude: -90 (South Pole) to +90 (North Pole)
    #   - Longitude: -180 to +180 (wraps at International Date Line)
    #
    # XSD Definition:
    #   - LatitudeDegrees (DegreesLatitude_t): Latitude in decimal degrees
    #   - LongitudeDegrees (DegreesLongitude_t): Longitude in decimal degrees
    #
    # @example New York City coordinates
    #   position = Position.new(
    #     'LatitudeDegrees' => 40.7128,
    #     'LongitudeDegrees' => -74.0060
    #   )
    #   puts "Location: #{position.latitude_degrees}°N, #{position.longitude_degrees.abs}°W"
    class Position < Base
      # Latitude coordinate in decimal degrees
      # Positive values are North, negative values are South
      # @return [Float] latitude (-90 to +90)
      property 'latitude_degrees', from: 'LatitudeDegrees', transform_with: lambda(&:to_f)

      # Longitude coordinate in decimal degrees
      # Positive values are East, negative values are West
      # @return [Float] longitude (-180 to +180)
      property 'longitude_degrees', from: 'LongitudeDegrees', transform_with: lambda(&:to_f)
    end
  end
end
