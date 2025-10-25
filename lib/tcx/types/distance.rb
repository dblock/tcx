# frozen_string_literal: true

module Tcx
  class Distance < Duration
    property 'meters', from: 'Meters', transform_with: lambda(&:to_i)
  end
end
