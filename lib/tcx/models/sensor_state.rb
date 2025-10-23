# frozen_string_literal: true

module Tcx
  class SensorState
    include Ruby::Enum

    define :present, 'Present'
    define :absent, 'Absent'
  end
end
