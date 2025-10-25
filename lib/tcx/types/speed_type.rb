# frozen_string_literal: true

module Tcx
  module Types
    # SpeedType_t (simple type, enumeration)
    #
    # Specifies how speed/pace should be displayed to the user.
    #
    # Values:
    #   - Pace: Display as time per distance (e.g., 8:00 min/mile, 5:00 min/km)
    #   - Speed: Display as distance per time (e.g., 7.5 mph, 12 km/h)
    #
    # Running typically uses Pace, while cycling typically uses Speed.
    #
    # @example Display as pace (running)
    #   type = SpeedType.parse('Pace')
    #
    # @example Display as speed (cycling)
    #   type = SpeedType.parse('Speed')
    #
    # @see CustomSpeedZone
    # @see Speed
    class SpeedType
      include Ruby::Enum

      # Display as pace (time per distance: min/mile or min/km)
      define :pace, 'Pace'

      # Display as speed (distance per time: mph or km/h)
      define :speed, 'Speed'
    end
  end
end
