# frozen_string_literal: true

module Tcx
  class Time < Base
    property 'seconds', from: 'Seconds', transform_with: lambda(&:to_i)

    def attributes
      super.merge('xsi:type' => 'Time_t')
    end
  end
end
