# frozen_string_literal: true

module Tcx
  class Value
    def self.parse(node)
      node.xpath('xmlns:Value').text
    end
  end
end
