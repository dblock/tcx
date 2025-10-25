# frozen_string_literal: true

module Tcx
  class Repeat < Step
    property 'repetitions', from: 'Repetitions', transform_with: lambda(&:to_i)
    property 'child', from: 'Child', transform_with: ->(v) { to_array(v).map { |el| Step.parse(el) } }
  end
end
