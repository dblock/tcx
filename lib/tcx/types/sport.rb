# frozen_string_literal: true

module Tcx
  module Types
    # Sport_t (simple type, enumeration)
    #
    # Specifies the type of sport/activity being performed.
    # This is a required attribute on Activity elements.
    #
    # XSD Definition (restriction of xsd:token):
    #   - Running: Running, jogging, trail running, treadmill
    #   - Biking: Cycling, mountain biking, indoor cycling
    #   - Other: All other sports (swimming, hiking, skiing, etc.)
    #
    # Note: The "Other" category is used for any sport not explicitly defined,
    # including swimming, cross-country skiing, rowing, etc.
    #
    # @example
    #   Sport.parse('Running')  # => Sport::RUNNING
    #   activity.sport          # => Sport::BIKING
    class Sport
      include Ruby::Enum

      # Running and jogging activities
      define :running, 'Running'

      # Cycling and biking activities
      define :biking, 'Biking'

      # All other sports (swimming, hiking, skiing, etc.)
      define :other, 'Other'
    end
  end
end
