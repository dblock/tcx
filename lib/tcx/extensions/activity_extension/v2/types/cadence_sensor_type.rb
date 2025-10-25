# frozen_string_literal: true

module Tcx
  module Extensions
    module ActivityExtension
      module V2
        module Types
          # CadenceSensorType_t (simple type, enumeration)
          #
          # Specifies the type of cadence sensor used to measure cadence data.
          #
          # Values:
          #   - Footpod: Running footpod sensor (measures running cadence)
          #   - Bike: Cycling cadence sensor (measures pedaling cadence)
          #
          # This is part of Garmin's Activity Extension v2 schema.
          #
          # @example Running with footpod
          #   sensor = CadenceSensorType.parse('Footpod')
          #
          # @example Cycling with bike sensor
          #   sensor = CadenceSensorType.parse('Bike')
          #
          # @see ActivityTrackpoint
          class CadenceSensorType
            include Ruby::Enum

            # Running footpod sensor
            define :footpod, 'Footpod'

            # Cycling cadence sensor
            define :bike, 'Bike'
          end
        end
      end
    end
  end
end
