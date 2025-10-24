# frozen_string_literal: true

module Tcx
  class Device < AbstractSource
    property 'unit_id', from: 'UnitId'
    property 'product_id', from: 'ProductID'
    property 'version', from: 'Version', transform_with: ->(v) { Version.parse(v) }

    def attributes
      super.merge('xsi:type' => 'Device_t')
    end
  end
end
