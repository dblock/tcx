# frozen_string_literal: true

module Tcx
  # UserInitiated_t (extends Duration_t)
  #
  # Represents a user-controlled duration for workout steps. Specifies that a step should
  # continue until the user manually advances to the next step via button press or screen tap.
  #
  # This duration type is useful for:
  #   - Flexible recovery periods: "Recover until ready, then press lap"
  #   - Self-paced intervals: "Run hard, press lap when done"
  #   - Adaptive workouts: User controls progression based on feel
  #
  # Unlike None_t (which is open-ended), UserInitiated explicitly requires user action
  # to advance the workout.
  #
  # XSD Definition:
  #   - (no properties - empty type)
  #
  # @example User-controlled recovery
  #   duration = UserInitiated.new
  #
  # @see Duration
  # @see Step
  # @see None
  class UserInitiated < Duration
  end
end
