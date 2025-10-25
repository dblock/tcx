# frozen_string_literal: true

module Tcx
  module Types
    # Workout_t
    #
    # Represents a structured workout plan consisting of multiple steps. Workouts can be
    # created in advance and sent to GPS devices for guided training sessions.
    #
    # A workout defines:
    #   - The sport type (Running, Biking, Other)
    #   - A sequence of steps (warm up, intervals, repeats, cool down)
    #   - Each step's duration, intensity, and target
    #   - Optional notes and creator information
    #
    # Workouts are typically created in training software (like Garmin Connect) and
    # synchronized to devices for execution during training.
    #
    # XSD Definition:
    #   - Name (Token): Workout name/title
    #   - Sport (Sport_t): Sport type (stored as XML attribute)
    #   - Step (AbstractStep_t): Sequence of workout steps
    #   - Creator (AbstractSource_t): Device or app that created the workout
    #   - Notes (Token): Optional training notes
    #   - Extensions (Extensions_t): Additional vendor-specific data
    #
    # @example Classic interval workout
    #   workout = Workout.new(
    #     'Name' => '5x1K Intervals',
    #     'Sport' => 'Running',
    #     'Step' => [
    #       { 'Name' => 'Warm Up', 'Duration' => { 'Seconds' => 600 }, 'Intensity' => 'Warmup' },
    #       { 'Repetitions' => 5, 'Child' => [
    #         { 'Name' => '1K Hard', 'Duration' => { 'Meters' => 1000 }, 'Intensity' => 'Active' },
    #         { 'Name' => 'Recovery', 'Duration' => { 'Seconds' => 120 }, 'Intensity' => 'Rest' }
    #       ]},
    #       { 'Name' => 'Cool Down', 'Duration' => { 'Seconds' => 300 }, 'Intensity' => 'Cooldown' }
    #     ]
    #   )
    #
    # @see Step
    # @see Repeat
    # @see Duration
    # @see Target
    class Workout < Base
      # Workout name/title
      # @return [String] workout name
      property 'name', from: 'Name'

      # Sport type for this workout (stored as XML attribute)
      # @return [Sport] sport enumeration (Running, Biking, Other)
      property 'sport', from: 'Sport', transform_with: ->(v) { Sport.parse(v) }

      # Sequence of workout steps (may include Repeat blocks)
      # @return [Array<Step>] array of steps defining the workout structure
      property 'steps', from: 'Step', transform_with: ->(v) { to_array(v).map { |el| Step.parse(el) } }

      # Device or application that created this workout
      # @return [AbstractSource, nil] creator information or nil
      property 'creator', from: 'Creator', transform_with: ->(v) { AbstractSource.parse(v) }

      # Optional training notes or instructions
      # @return [String, nil] notes text or nil
      property 'notes', from: 'Notes'

      # Vendor-specific extensions
      # @return [ExtensionsList, nil] extensions or nil
      property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

      # XML attributes for this type
      # @return [Array<String>] attribute names
      def self.attributes
        ['sport']
      end
    end
  end
end
