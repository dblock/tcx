# frozen_string_literal: true

module Tcx
  class ExtensionsList < Base
    # TODO: forward all extension properties up
    property 'TPX', transform_with: ->(v) { Tcx::Extensions::ActivityExtension::V2::ActivityTrackpoint.parse(v) }
    property 'LX', transform_with: ->(v) { Tcx::Extensions::ActivityExtension::V2::ActivityLap.parse(v) }
  end
end
