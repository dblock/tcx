# frozen_string_literal: true

module Tcx
  class AbstractSource < Base
    property 'name', from: 'Name'
    property 'unit_id', from: 'UnitId'
    property 'product_id', from: 'ProductID'
    property 'version', from: 'Version', transform_with: ->(v) { Version.parse(v) }
  end
end
