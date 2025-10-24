# frozen_string_literal: true

module Tcx
  class Cadence < Base
    extend Forwardable

    property 'value', from: 'Value', transform_with: lambda(&:to_i)

    def_delegators :value, :to_i, :==
  end
end
