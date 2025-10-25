# frozen_string_literal: true

module Tcx
  module Types
    # Repeat_t (extends AbstractStep_t)
    #
    # Represents a repeating block of workout steps. Used to define interval training
    # where a sequence of steps is repeated multiple times.
    #
    # Common use cases:
    #   - Interval training: Repeat 8x (400m hard + 200m recovery)
    #   - Pyramid workouts: Repeat 3x (1 mile tempo + 2 min rest)
    #   - Hill repeats: Repeat 6x (2 min uphill + 2 min downhill recovery)
    #
    # XSD Definition:
    #   - Repetitions (Repetitions_t): Number of times to repeat (1-100)
    #   - Child (AbstractStep_t): Steps to repeat (can include nested Repeat blocks)
    #
    # @example Classic interval workout: 5 x (800m hard + 400m recovery)
    #   repeat = Repeat.new(
    #     'Repetitions' => 5,
    #     'Child' => [
    #       { 'Duration' => { 'Meters' => 800 }, 'Intensity' => 'Active', 'Target' => { 'HeartRateZone' => { 'Number' => 4 } } },
    #       { 'Duration' => { 'Meters' => 400 }, 'Intensity' => 'Rest', 'Target' => { 'HeartRateZone' => { 'Number' => 2 } } }
    #     ]
    #   )
    #
    # @see Step
    # @see Workout
    class Repeat < Step
      # Number of times to repeat the child steps
      # @return [Integer] repetition count (1-100)
      property 'repetitions', from: 'Repetitions', transform_with: lambda(&:to_i)

      # The steps to repeat (can be a single step or multiple steps)
      # @return [Array<Step>] array of child steps (may include nested Repeat blocks)
      property 'child', from: 'Child', transform_with: ->(v) { to_array(v).map { |el| Step.parse(el) } }
    end
  end
end
