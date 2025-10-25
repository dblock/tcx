# frozen_string_literal: true

module Tcx
  class TrainingType
    include Ruby::Enum

    define :workout, 'Workout'
    define :course, 'Course'
  end
end
