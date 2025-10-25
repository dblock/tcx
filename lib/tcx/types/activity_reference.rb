# frozen_string_literal: true

module Tcx
  class ActivityReference < Base
    property 'id', from: 'Id', transform_with: ->(v) { ::Time.parse(v) }
  end
end
