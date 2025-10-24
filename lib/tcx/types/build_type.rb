# frozen_string_literal: true

module Tcx
  class BuildType
    include Ruby::Enum

    define :internal, 'Internal'
    define :alpha, 'Alpha'
    define :beta, 'Beta'
    define :release, 'Release'
  end
end
