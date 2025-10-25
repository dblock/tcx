# frozen_string_literal: true

module Tcx
  class Training < Base
    property 'quick_workout_results', from: 'QuickWorkoutResults', transform_with: ->(v) { QuickWorkout.parse(v) }
    property 'plan', from: 'Plan', transform_with: ->(v) { Plan.parse(v) }

    property 'virtual_partner', from: 'VirtualPartner', transform_with: lambda { |v|
      case v
      when 'true'
        true
      when 'false'
        false
      end
    }

    def attributes
      super.merge('xsi:type' => 'Application_t')
    end
  end
end
