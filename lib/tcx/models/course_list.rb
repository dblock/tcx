# frozen_string_literal: true

module Tcx
  class CourseList
    def self.parse(list)
      list.xpath('xmlns:Course').map { |el| Course.parse(el) }
    end
  end
end
