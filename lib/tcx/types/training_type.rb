# frozen_string_literal: true

module Tcx
  module Types
    # TrainingType_t (simple type, enumeration)
    #
    # Specifies the type of training plan or structured workout.
    #
    # Values:
    #   - Workout: A structured workout with steps, durations, and targets
    #   - Course: A route-based training plan following a specific geographic course
    #
    # @example Workout-based training
    #   type = TrainingType.parse('Workout')
    #
    # @example Course-based training
    #   type = TrainingType.parse('Course')
    #
    # @see Plan
    # @see Training
    class TrainingType
      include Ruby::Enum

      # Structured workout with defined steps
      define :workout, 'Workout'

      # Route-based training following a course
      define :course, 'Course'
    end
  end
end
