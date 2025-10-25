# frozen_string_literal: true

module Tcx
  class NextSport < Base
    property 'transition', from: 'Transition', transform_with: ->(v) { Lap.parse(v) }
    property 'activity', from: 'Activity', transform_with: ->(v) { Activity.parse(v) }
  end
end
