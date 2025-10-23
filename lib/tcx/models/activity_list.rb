# frozen_string_literal: true

module Tcx
  class ActivityList
    def self.parse(list)
      list.xpath('xmlns:Activity').map { |el| Activity.parse(el) }
    end
  end
end
