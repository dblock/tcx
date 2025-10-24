# frozen_string_literal: true

module Tcx
  module Extensions
    module ActivityExtension
      module V2
        class CadenceSensorType
          include Ruby::Enum

          define :footpod, 'Footpod'
          define :bike, 'Bike'
        end
      end
    end
  end
end
