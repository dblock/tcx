# frozen_string_literal: true

module Tcx
  class Gender
    include Ruby::Enum

    define :male, 'Male'
    define :female, 'Female'
  end
end
