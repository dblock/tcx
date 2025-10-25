# frozen_string_literal: true

module Tcx
  module Types
    # Gender_t (simple type, enumeration)
    #
    # Specifies biological sex/gender for athlete profile or user data.
    # Used in various contexts where gender-specific calculations are needed
    # (e.g., heart rate zones, calorie burn estimates).
    #
    # XSD Definition (restriction of xsd:token):
    #   - Male: Male gender
    #   - Female: Female gender
    #
    # @example
    #   Gender.parse('Male')  # => Gender::MALE
    class Gender
      include Ruby::Enum

      # Male gender
      define :male, 'Male'

      # Female gender
      define :female, 'Female'
    end
  end
end
