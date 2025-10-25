# frozen_string_literal: true

module Tcx
  module Types
    # PredefinedSpeedZone_t (extends Zone_t)
    #
    # References one of the standard 5 speed/pace zones commonly used in training.
    # Similar to heart rate zones, but based on pace or speed rather than HR.
    #
    # Typical zone definitions (for running):
    #   - Zone 1: Easy/Recovery pace
    #   - Zone 2: Aerobic/Long run pace
    #   - Zone 3: Tempo/Threshold pace
    #   - Zone 4: Interval pace
    #   - Zone 5: Sprint/VO2 Max pace
    #
    # The exact pace ranges are individual and depend on race times or lactate threshold.
    #
    # XSD Definition:
    #   - Number (unsignedByte): Zone number (1-5)
    #
    # @example Zone 3 (tempo pace) training
    #   zone = PredefinedSpeedZone.new('Number' => 3)
    #
    # @see Zone
    # @see CustomSpeedZone
    # @see Speed
    class PredefinedSpeedZone < Zone
      # Standard zone number (1-5)
      # @return [Integer] zone number (1-5)
      property 'number', from: 'Number', transform_with: lambda(&:to_i)
    end
  end
end
