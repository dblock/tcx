# frozen_string_literal: true

module Tcx
  module Extensions
    module ActivityExtension
      module V2
        module Types
          # LX
          class Base < Tcx::Types::Base
            def self.namespace
              'http://www.garmin.com/xmlschemas/ActivityExtension/v2'
            end
          end
        end
      end
    end
  end
end
