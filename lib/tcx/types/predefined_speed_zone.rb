# frozen_string_literal: true

module Tcx
  class PredefinedSpeedZone < Zone
    property 'number', from: 'Number', transform_with: lambda(&:to_i)
  end
end
