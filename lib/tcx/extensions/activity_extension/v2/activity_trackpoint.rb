# frozen_string_literal: true

module Tcx
  module Extensions
    module ActivityExtension
      module V2
        # TPX
        class ActivityTrackpoint < Base
          property 'speed', from: 'Speed', transform_with: lambda(&:to_f)
          property 'run_cadence', from: 'RunCadence', transform_with: lambda(&:to_i)
          property 'watts', from: 'Watts', transform_with: lambda(&:to_i)
          property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
          property 'cadence_sensor', from: 'CadenceSensor', transform_with: ->(v) { CadenceSensorType.parse(v) }

          def self.attributes
            ['cadence_sensor']
          end
        end
      end
    end
  end
end
