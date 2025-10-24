# frozen_string_literal: true

module Tcx
  class Step < Base
    property 'step_id', from: 'StepId'
    property 'name', from: 'Name'
    property 'duration', from: 'Duration', transform_with: ->(v) { Duration.parse(v) }
    property 'intensity', from: 'Intensity', transform_with: ->(v) { Intensity.parse(v) }
    property 'target', from: 'Target', transform_with: ->(v) { Target.parse(v) }
  end
end
