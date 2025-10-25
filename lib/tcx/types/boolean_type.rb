# frozen_string_literal: true

module Tcx
  class BooleanType
    include Ruby::Enum

    define :true, 'true' # rubocop:disable Lint/BooleanSymbol
    define :false, 'false' # rubocop:disable Lint/BooleanSymbol
  end
end
