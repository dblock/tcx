# frozen_string_literal: true

module Tcx
  class PredefinedHeartRateZone < Base
    property 'numbers', from: 'Number', transform_with: lambda(&:to_i)
  end
end
