# frozen_string_literal: true

module Tcx
  class Week < Base
    property 'notes', from: 'Notes'

    def self.attributes
      %w[start_day]
    end

    property 'start_day', from: 'StartDay', transform_with: ->(v) { Date.parse(v) }
  end
end
