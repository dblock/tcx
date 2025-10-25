# frozen_string_literal: true

module Tcx
  class CadenceTarget < Target
    property 'low', from: 'Low', transform_with: lambda(&:to_f)
    property 'high', from: 'High', transform_with: lambda(&:to_f)
  end
end
