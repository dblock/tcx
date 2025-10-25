# frozen_string_literal: true

module Tcx
  # Intensity_t (simple type, enumeration)
  #
  # Indicates the intensity level of a lap or workout step.
  # Used to distinguish between active exercise and recovery/rest periods.
  #
  # XSD Definition (restriction of xsd:token):
  #   - Active: Active exercise lap (normal workout intensity)
  #   - Resting: Recovery or rest lap (low intensity, cool-down, warm-up)
  #
  # @example
  #   lap.intensity  # => Intensity::ACTIVE
  #   Intensity.parse('Resting')  # => Intensity::RESTING
  class Intensity
    include Ruby::Enum

    # Active exercise intensity
    define :active, 'Active'

    # Resting/recovery intensity
    define :resting, 'Resting'
  end
end
