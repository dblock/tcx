# frozen_string_literal: true

module Tcx
  module Extensions
    module ActivityExtension
      module V2
        # LX
        class ActivityLap < Base
          property 'avg_speed', from: 'AvgSpeed', transform_with: lambda(&:to_f)
          property 'max_bike_cadence', from: 'MaxBikeCadence', transform_with: lambda(&:to_i)
          property 'avg_run_cadence', from: 'AvgRunCadence', transform_with: lambda(&:to_i)
          property 'max_run_cadence', from: 'MaxRunCadence', transform_with: lambda(&:to_i)
          property 'steps', from: 'Steps', transform_with: lambda(&:to_i)
          property 'avg_watts', from: 'AvgWatts', transform_with: lambda(&:to_i)
          property 'max_watts', from: 'MaxWatts', transform_with: lambda(&:to_i)
          property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
        end
      end
    end
  end
end
