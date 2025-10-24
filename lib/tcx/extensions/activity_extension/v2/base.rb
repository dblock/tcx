# frozen_string_literal: true

module Tcx
  module Extensions
    module ActivityExtension
      module V2
        # LX
        class Base < Tcx::Base
          def self.namespace
            'http://www.garmin.com/xmlschemas/ActivityExtension/v2'
          end
        end
      end
    end
  end
end
