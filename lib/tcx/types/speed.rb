# frozen_string_literal: true

module Tcx
  class Speed < Target
    property 'speed_zone', from: 'SpeedZone', transform_with: ->(v) { Zone.parse(v) }
  end
end
