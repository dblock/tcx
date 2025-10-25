# frozen_string_literal: true

module Tcx
  # PredefinedHeartRateZone_t (extends Zone_t)
  #
  # References one of the standard 5 heart rate zones (1-5) commonly used in training.
  # These zones are typically defined as percentages of maximum heart rate:
  #   - Zone 1: 50-60% (Recovery)
  #   - Zone 2: 60-70% (Aerobic/Easy)
  #   - Zone 3: 70-80% (Tempo)
  #   - Zone 4: 80-90% (Threshold)
  #   - Zone 5: 90-100% (VO2 Max)
  #
  # The exact BPM ranges are calculated based on individual max heart rate.
  #
  # XSD Definition:
  #   - Number (HeartRateZoneNumbers_t): Zone number (1-5)
  #
  # @example Zone 3 (tempo) training
  #   zone = PredefinedHeartRateZone.new('Number' => 3)
  #
  # @see Zone
  # @see CustomHeartRateZone
  class PredefinedHeartRateZone < Base
    # Standard zone number (1-5)
    # @return [Integer] zone number (1-5)
    property 'numbers', from: 'Number', transform_with: lambda(&:to_i)
  end
end
