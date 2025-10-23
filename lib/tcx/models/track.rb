# frozen_string_literal: true

module Tcx
  class Track < Base
    property 'trackpoints', from: 'Trackpoint', transform_with: ->(v) { to_array(v).map { |el| Trackpoint.parse(el) } }
  end
end
