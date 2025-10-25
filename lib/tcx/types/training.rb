# frozen_string_literal: true

module Tcx
  # Training_t
  #
  # Container for training-related information stored in an activity. Can contain either
  # quick workout results (on-the-fly workout created on device) or a reference to a
  # structured training plan.
  #
  # This type is typically used when an activity was performed following a workout plan,
  # allowing the TCX file to link the completed activity back to its planned workout.
  #
  # XSD Definition:
  #   - QuickWorkoutResults (QuickWorkout_t): Results from ad-hoc workout
  #   - Plan (Plan_t): Reference to training plan
  #   - VirtualPartner (boolean): Whether virtual partner feature was used (XML attribute)
  #
  # Virtual Partner is a Garmin feature that paces you against a virtual competitor
  # during the workout.
  #
  # @example Activity with training plan reference
  #   training = Training.new(
  #     'Plan' => {
  #       'Name' => 'Marathon Training Week 8',
  #       'Type' => 'Race'
  #     },
  #     'VirtualPartner' => false
  #   )
  #
  # @see Plan
  # @see QuickWorkout
  # @see Activity
  class Training < Base
    # Results from a quick/ad-hoc workout created on device
    # @return [QuickWorkout, nil] quick workout or nil
    property 'quick_workout_results', from: 'QuickWorkoutResults', transform_with: ->(v) { QuickWorkout.parse(v) }

    # Reference to a structured training plan
    # @return [Plan, nil] training plan or nil
    property 'plan', from: 'Plan', transform_with: ->(v) { Plan.parse(v) }

    # Whether virtual partner feature was enabled (stored as XML attribute)
    # @return [Boolean] true if virtual partner was used
    property 'virtual_partner', from: 'VirtualPartner', transform_with: ->(v) { BooleanType.parse(v) }

    # XML attributes for this type
    # @return [Array<String>] attribute names
    def self.attributes
      ['virtual_partner']
    end
  end
end
