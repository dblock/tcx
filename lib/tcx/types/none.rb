# frozen_string_literal: true

module Tcx
  class None < Base
    def attributes
      super.merge('xsi:type' => 'None_t')
    end
  end
end
