# frozen_string_literal: true

module Tcx
  # CustomHeartRateZone_t (extends Zone_t)
  #
  # Defines a custom heart rate zone with specific low and high BPM boundaries.
  # Allows precise control over workout intensity zones beyond the standard 5-zone model.
  #
  # XSD Definition:
  #   - Low (unsignedByte): Lower boundary in BPM
  #   - High (unsignedByte): Upper boundary in BPM
  #
  # @example Tempo zone 155-165 BPM
  #   zone = CustomHeartRateZone.new('Low' => 155, 'High' => 165)
  #
  # @see Zone
  # @see PredefinedHeartRateZone
  class CustomHeartRateZone < Base
    # Lower heart rate boundary in beats per minute
    # @return [Integer] low BPM value (0-255)
    property 'low', from: 'Low', transform_with: lambda(&:to_i)

    # Upper heart rate boundary in beats per minute
    # @return [Integer] high BPM value (0-255)
    property 'high', from: 'High', transform_with: lambda(&:to_i)
  end
end
