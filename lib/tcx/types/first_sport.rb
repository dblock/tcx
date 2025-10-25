# frozen_string_literal: true

module Tcx
  class FirstSport < Base
    property 'activity', from: 'Activity', transform_with: ->(v) { Activity.parse(v) }
  end
end
