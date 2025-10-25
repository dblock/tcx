# frozen_string_literal: true

module Tcx
  class Plan < Base
    property 'name', from: 'Name'
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
    property 'type', from: 'Type', transform_with: ->(v) { TrainingType.parse(v) }
    property 'interval_workout', from: 'IntervalWorkout', transform_with: ->(v) { v == 'true' }

    def self.attributes
      %w[type interval_workout]
    end
  end
end
