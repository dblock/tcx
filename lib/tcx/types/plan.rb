# frozen_string_literal: true

module Tcx
  # Plan_t
  #
  # Represents a training plan that an activity followed. Provides metadata about the
  # planned workout, including its type and whether it was an interval workout.
  #
  # Training plans are typically part of a larger training program (e.g., marathon training,
  # base building, race preparation) and are created in advance using training software.
  #
  # XSD Definition:
  #   - Name (Token): Plan name/identifier
  #   - Type (TrainingType_t): Type of training (Race, Workout, etc.) - XML attribute
  #   - IntervalWorkout (boolean): Whether this is an interval workout - XML attribute
  #   - Extensions (Extensions_t): Additional vendor-specific data
  #
  # @example Race day workout plan
  #   plan = Plan.new(
  #     'Name' => 'Half Marathon Race',
  #     'Type' => 'Race',
  #     'IntervalWorkout' => false
  #   )
  #
  # @example Interval training plan
  #   plan = Plan.new(
  #     'Name' => 'Threshold Intervals',
  #     'Type' => 'Workout',
  #     'IntervalWorkout' => true
  #   )
  #
  # @see Training
  # @see Workout
  # @see TrainingType
  class Plan < Base
    # Plan name or identifier
    # @return [String] plan name
    property 'name', from: 'Name'

    # Vendor-specific extensions
    # @return [ExtensionsList, nil] extensions or nil
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    # Type of training (stored as XML attribute)
    # @return [TrainingType] training type enumeration
    property 'type', from: 'Type', transform_with: ->(v) { TrainingType.parse(v) }

    # Whether this is an interval workout (stored as XML attribute)
    # @return [Boolean] true if interval workout
    property 'interval_workout', from: 'IntervalWorkout', transform_with: ->(v) { BooleanType.parse(v) }

    # XML attributes for this type
    # @return [Array<String>] attribute names
    def self.attributes
      %w[interval_workout type]
    end
  end
end
