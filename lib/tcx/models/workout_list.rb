# frozen_string_literal: true

module Tcx
  class WorkoutList
    def self.parse(list)
      list.xpath('xmlns:Workout').map { |el| Workout.parse(el) }
    end
  end
end
