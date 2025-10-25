# frozen_string_literal: true

module Tcx
  # BooleanType (simple type, enumeration)
  #
  # XML representation of boolean values. TCX uses string literals 'true' and 'false'
  # rather than native XML boolean type.
  #
  # This type is used for XML attributes that require boolean values, such as:
  #   - VirtualPartner (in Training_t)
  #   - IntervalWorkout (in Plan_t)
  #
  # @example Parse boolean from XML
  #   bool = BooleanType.parse('true')
  #
  # @see Training
  # @see Plan
  class BooleanType
    include Ruby::Enum

    # True value
    define :true, 'true' # rubocop:disable Lint/BooleanSymbol

    # False value
    define :false, 'false' # rubocop:disable Lint/BooleanSymbol
  end
end
