# frozen_string_literal: true

module Tcx
  class Intensity
    include Ruby::Enum

    define :active, 'Active'
    define :resting, 'Resting'
  end
end
