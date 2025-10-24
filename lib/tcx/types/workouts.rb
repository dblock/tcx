# frozen_string_literal: true

module Tcx
  class Workouts < Base
    property 'running', from: 'Running', transform_with: ->(v) { WorkoutFolder.parse(v) }
    property 'biking', from: 'Biking', transform_with: ->(v) { WorkoutFolder.parse(v) }
    property 'other', from: 'Other', transform_with: ->(v) { WorkoutFolder.parse(v) }
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
  end
end
