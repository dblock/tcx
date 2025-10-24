# frozen_string_literal: true

module Tcx
  class TriggerMethod
    include Ruby::Enum

    define :manual, 'Manual'
    define :distance, 'Distance'
    define :location, 'Location'
    define :time, 'Time'
    define :heart_rate, 'HeartRate'
  end
end
