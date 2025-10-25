# frozen_string_literal: true

module Tcx
  class SpeedType
    include Ruby::Enum

    define :pace, 'Pace'
    define :speed, 'Speed'
  end
end
