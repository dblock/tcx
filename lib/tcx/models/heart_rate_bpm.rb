# frozen_string_literal: true

module Tcx
  class HeartRateBpm < Value
    def self.parse(node)
      Value.parse(node).to_i
    end
  end
end
