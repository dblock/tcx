# frozen_string_literal: true

module Tcx
  class WorkoutList < Base
    property 'workouts', from: 'Workouts', transform_with: ->(v) { v.map { |el| Workout.parse(el) } }

    def_delegators :workouts, :each, :count

    def self.parse(list)
      WorkoutList.new('Workouts' => list.xpath('xmlns:Workout'))
    end

    def build_xml(builder, namespace = nil)
      workouts.each do |workout|
        builder.Workout do |workout_builder|
          workout.build_xml(workout_builder, namespace)
        end
      end
    end
  end
end
