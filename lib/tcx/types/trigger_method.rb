# frozen_string_literal: true

module Tcx
  # TriggerMethod_t (simple type, enumeration)
  #
  # Specifies how a lap was triggered/started during an activity.
  # Different trigger methods provide different workout structuring capabilities.
  #
  # XSD Definition (restriction of xsd:token):
  #   - Manual: User manually pressed lap button
  #   - Distance: Lap triggered automatically after specific distance
  #   - Location: Lap triggered when reaching GPS waypoint/location
  #   - Time: Lap triggered automatically after specific time duration
  #   - HeartRate: Lap triggered when heart rate crosses threshold
  #
  # @example
  #   lap.trigger_method  # => TriggerMethod::MANUAL
  #   TriggerMethod.parse('Distance')  # => TriggerMethod::DISTANCE
  class TriggerMethod
    include Ruby::Enum

    # User manually triggered the lap
    define :manual, 'Manual'

    # Lap auto-triggered by distance (e.g., every 1km)
    define :distance, 'Distance'

    # Lap triggered by reaching a specific location/waypoint
    define :location, 'Location'

    # Lap auto-triggered by time (e.g., every 10 minutes)
    define :time, 'Time'

    # Lap triggered by heart rate threshold
    define :heart_rate, 'HeartRate'
  end
end
