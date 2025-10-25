# frozen_string_literal: true

module Tcx
  module Types
    # AbstractStep_t / Step_t (base class for workout steps)
    #
    # Represents a single step in a structured workout. A workout consists of a sequence
    # of steps, each with a duration, intensity, and target. Steps can be simple intervals
    # or complex repeating blocks.
    #
    # For example, a typical interval workout might be:
    #   1. Warm up (10 min, easy intensity, HR zone 2)
    #   2. Repeat 5x: Run hard (3 min, active intensity, HR zone 4) + Recover (2 min, rest, HR zone 2)
    #   3. Cool down (5 min, easy intensity, HR zone 1)
    #
    # XSD Definition:
    #   - StepId (StepId_t): Unique step identifier (0-20)
    #   - Name (Token): Display name for the step
    #   - Duration (Duration_t): How long this step lasts
    #   - Intensity (Intensity_t): Effort level (Active, Rest, Warmup, Cooldown)
    #   - Target (Target_t): Performance target (HR zone, pace, cadence, power)
    #
    # @example 20-minute tempo run in HR zone 4
    #   step = Step.new(
    #     'StepId' => 1,
    #     'Name' => 'Tempo',
    #     'Duration' => { 'Seconds' => 1200 },
    #     'Intensity' => 'Active',
    #     'Target' => { 'HeartRateZone' => { 'Number' => 4 } }
    #   )
    #
    # @see Workout
    # @see Repeat
    # @see Duration
    # @see Target
    class Step < Base
      # Unique identifier for this step (0-20)
      # @return [Integer] step ID
      property 'step_id', from: 'StepId'

      # Display name for this step
      # @return [String] step name
      property 'name', from: 'Name'

      # How long this step should last
      # @return [Duration] duration specification (time, distance, HR threshold, or calories)
      property 'duration', from: 'Duration', transform_with: ->(v) { Duration.parse(v) }

      # Effort level for this step
      # @return [Intensity] intensity enumeration (Active, Rest, Warmup, Cooldown, Recovery)
      property 'intensity', from: 'Intensity', transform_with: ->(v) { Intensity.parse(v) }

      # Performance target to maintain during this step
      # @return [Target] target specification (HR zone, pace zone, cadence, or power zone)
      property 'target', from: 'Target', transform_with: ->(v) { Target.parse(v) }
    end
  end
end
