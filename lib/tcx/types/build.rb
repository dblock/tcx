# frozen_string_literal: true

module Tcx
  class Build < Base
    property 'version', from: 'Version', transform_with: ->(v) { Version.parse(v) }
    property 'type', from: 'Type', transform_with: ->(v) { BuildType.parse(v) }
    property 'time', from: 'Time', transform_with: ->(v) { Time.parse(v) }
    property 'builder', from: 'Builder'
  end
end
