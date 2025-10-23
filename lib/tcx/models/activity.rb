# frozen_string_literal: true

module Tcx
  class Activity < Base
    property 'sport', from: 'Sport', transform_with: ->(v) { Sport.parse(v) }
    property 'id', from: 'Id'
    property 'laps', from: 'Lap', transform_with: ->(v) { to_array(v).map { |el| Lap.parse(el) } }
    property 'notes', from: 'Notes'
    property 'creator', from: 'Creator', transform_with: ->(v) { AbstractSource.parse(v) }
  end
end
