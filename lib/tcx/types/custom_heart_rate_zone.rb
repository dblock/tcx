# frozen_string_literal: true

module Tcx
  class CustomHeartRateZone < Base
    property 'low', from: 'Low', transform_with: lambda(&:to_i)
    property 'high', from: 'High', transform_with: lambda(&:to_i)
  end
end
