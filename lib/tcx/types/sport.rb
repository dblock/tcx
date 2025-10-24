# frozen_string_literal: true

module Tcx
  class Sport
    include Ruby::Enum

    define :running, 'Running'
    define :biking, 'Biking'
    define :other, 'Other'
  end
end
