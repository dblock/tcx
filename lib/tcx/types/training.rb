# frozen_string_literal: true

module Tcx
  class Training < Base
    property 'quick_workout_results', from: 'QuickWorkoutResults', transform_with: ->(v) { QuickWorkout.parse(v) }
    property 'plan', from: 'Plan', transform_with: ->(v) { Plan.parse(v) }

    property 'virtual_partner', from: 'VirtualPartner', transform_with: ->(v) { BooleanType.parse(v) }

    def self.attributes
      ['virtual_partner']
    end
  end
end
