# frozen_string_literal: true

module Tcx
  # SensorState_t (simple type, enumeration)
  #
  # Indicates whether a sensor (typically heart rate monitor) was connected
  # and providing data at a given trackpoint.
  #
  # XSD Definition (restriction of xsd:token):
  #   - Present: Sensor connected and transmitting data
  #   - Absent: Sensor disconnected or not transmitting
  #
  # This helps distinguish between missing heart rate data due to sensor
  # disconnection versus intentionally not wearing a heart rate monitor.
  #
  # @example
  #   trackpoint.sensor_state  # => SensorState::PRESENT
  #   SensorState.parse('Absent')  # => SensorState::ABSENT
  class SensorState
    include Ruby::Enum

    # Sensor is connected and transmitting data
    define :present, 'Present'

    # Sensor is disconnected or not transmitting
    define :absent, 'Absent'
  end
end
