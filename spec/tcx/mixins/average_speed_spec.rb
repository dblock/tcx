# frozen_string_literal: true

require 'spec_helper'

describe Tcx::Mixins::AverageSpeed do
  let(:file_path) { File.join(File.dirname(__FILE__), '../../data/running/running_activity_1.tcx') }
  let(:tcx) { Tcx.load_file(file_path) }
  let(:activity) { tcx.activities.first }
  let(:lap) { activity.laps.first }

  describe 'Activity' do
    describe '#average_speed' do
      it 'returns the average speed in meters per second' do
        expect(activity.average_speed).to be_a(Float)
        expect(activity.average_speed).to be > 0
      end

      it 'calculates speed from distance and time' do
        # distance_meters / total_time_seconds
        expected = activity.distance_meters / activity.total_time_seconds
        expect(activity.average_speed).to eq(expected)
      end
    end

    describe '#average_speed_meters_per_second' do
      it 'returns the same as average_speed' do
        expect(activity.average_speed_meters_per_second).to eq(activity.average_speed)
      end
    end

    describe '#average_speed_kilometer_per_hour_s' do
      it 'formats speed as km/h' do
        expect(activity.average_speed_kilometer_per_hour_s).to match(%r{\d+\.\dkm/h})
      end
    end

    describe '#average_speed_miles_per_hour_s' do
      it 'formats speed as mph' do
        expect(activity.average_speed_miles_per_hour_s).to match(/\d+\.\dmph/)
      end
    end

    describe '#pace_per_kilometer_s' do
      it 'formats pace as min/km' do
        expect(activity.pace_per_kilometer_s).to match(%r{\d+m\d+s/km})
      end
    end

    describe '#pace_per_mile_s' do
      it 'formats pace as min/mi' do
        expect(activity.pace_per_mile_s).to match(%r{\d+m\d+s/mi})
      end
    end
  end

  describe 'Lap' do
    describe '#average_speed' do
      it 'returns the average speed in meters per second from extensions' do
        expect(lap.average_speed).to be_a(Float)
        expect(lap.average_speed).to be > 0
      end
    end

    describe '#avg_speed' do
      it 'is an alias for average_speed' do
        expect(lap.avg_speed).to eq(lap.average_speed)
      end
    end
  end

  describe 'ActivityLap' do
    let(:activity_lap) { lap.extensions.LX }

    describe '#average_speed' do
      it 'is an alias for avg_speed' do
        expect(activity_lap.average_speed).to eq(activity_lap.avg_speed)
      end
    end

    describe '#average_speed_meters_per_second' do
      it 'returns the same as average_speed' do
        expect(activity_lap.average_speed_meters_per_second).to eq(activity_lap.average_speed)
      end
    end

    describe '#average_speed_kilometer_per_hour_s' do
      it 'formats speed as km/h' do
        expect(activity_lap.average_speed_kilometer_per_hour_s).to match(%r{\d+\.\dkm/h})
      end

      it 'converts correctly' do
        # average_speed is 4.96999979019165 m/s
        # 4.96999979019165 * 3.6 = 17.891999244689934 km/h
        expect(activity_lap.average_speed_kilometer_per_hour_s).to eq('17.9km/h')
      end
    end

    describe '#average_speed_miles_per_hour_s' do
      it 'formats speed as mph' do
        expect(activity_lap.average_speed_miles_per_hour_s).to match(/\d+\.\dmph/)
      end

      it 'converts correctly' do
        # average_speed is 4.96999979019165 m/s
        # 4.96999979019165 * 2.23694 = 11.117962155648925 mph
        expect(activity_lap.average_speed_miles_per_hour_s).to eq('11.1mph')
      end
    end

    describe '#pace_per_kilometer_s' do
      it 'converts correctly' do
        # average_speed is 4.96999979019165 m/s
        # 1000 / (4.96999979019165 * 60) = 3.3557047 min/km
        # 3 minutes 21 seconds
        expect(activity_lap.pace_per_kilometer_s).to eq('3m21s/km')
      end
    end

    describe '#pace_per_mile_s' do
      it 'converts correctly' do
        # average_speed is 4.96999979019165 m/s
        # 1609.344 / (4.96999979019165 * 60) = 5.3999999 min/mi
        # 5 minutes 24 seconds
        expect(activity_lap.pace_per_mile_s).to eq('5m24s/mi')
      end
    end

    describe '#average_speed_meters_per_second' do
      it 'returns the same as average_speed' do
        expect(lap.average_speed_meters_per_second).to eq(lap.average_speed)
      end
    end

    describe '#avg_speed_meters_per_second' do
      it 'is an alias for average_speed_meters_per_second' do
        expect(lap.avg_speed_meters_per_second).to eq(lap.average_speed_meters_per_second)
      end
    end

    describe '#average_speed_kilometer_per_hour_s' do
      it 'formats speed as km/h' do
        expect(lap.average_speed_kilometer_per_hour_s).to match(%r{\d+\.\dkm/h})
      end

      it 'converts correctly' do
        # average_speed is 4.96999979019165 m/s
        # 4.96999979019165 * 3.6 = 17.891999244689934 km/h
        expect(lap.average_speed_kilometer_per_hour_s).to eq('17.9km/h')
      end
    end

    describe '#avg_speed_kilometer_per_hour_s' do
      it 'is an alias for average_speed_kilometer_per_hour_s' do
        expect(lap.avg_speed_kilometer_per_hour_s).to eq(lap.average_speed_kilometer_per_hour_s)
      end
    end

    describe '#average_speed_miles_per_hour_s' do
      it 'formats speed as mph' do
        expect(lap.average_speed_miles_per_hour_s).to match(/\d+\.\dmph/)
      end

      it 'converts correctly' do
        # average_speed is 4.96999979019165 m/s
        # 4.96999979019165 * 2.23694 = 11.117962155648925 mph
        expect(lap.average_speed_miles_per_hour_s).to eq('11.1mph')
      end
    end

    describe '#avg_speed_miles_per_hour_s' do
      it 'is an alias for average_speed_miles_per_hour_s' do
        expect(lap.avg_speed_miles_per_hour_s).to eq(lap.average_speed_miles_per_hour_s)
      end
    end

    describe '#average_speed_s' do
      it 'returns the same as average_speed_kilometer_per_hour_s' do
        expect(lap.average_speed_s).to eq(lap.average_speed_kilometer_per_hour_s)
      end
    end

    describe '#avg_speed_s' do
      it 'is an alias for average_speed_s' do
        expect(lap.avg_speed_s).to eq(lap.average_speed_s)
      end
    end

    describe '#pace_per_kilometer_s' do
      it 'formats pace as min/km' do
        expect(lap.pace_per_kilometer_s).to match(%r{\d+m\d+s/km})
      end

      it 'converts correctly' do
        # avg_speed is 4.96999979019165 m/s
        # 1000 / (4.96999979019165 * 60) = 3.3557047 min/km
        # 3 minutes 21 seconds
        expect(lap.pace_per_kilometer_s).to eq('3m21s/km')
      end
    end

    describe '#pace_per_mile_s' do
      it 'formats pace as min/mi' do
        expect(lap.pace_per_mile_s).to match(%r{\d+m\d+s/mi})
      end

      it 'converts correctly' do
        # avg_speed is 4.96999979019165 m/s
        # 1609.344 / (4.96999979019165 * 60) = 5.3999999 min/mi
        # 5 minutes 24 seconds
        expect(lap.pace_per_mile_s).to eq('5m24s/mi')
      end
    end

    describe '#pace_per_100_meters_s' do
      it 'formats pace as min/100m' do
        expect(lap.pace_per_100_meters_s).to match(%r{\d+m\d+s/100m})
      end

      it 'converts correctly' do
        # avg_speed is 4.96999979019165 m/s
        # 100 / (4.96999979019165 * 60) = 0.33557047 min/100m
        # 0 minutes 20 seconds
        expect(lap.pace_per_100_meters_s).to eq('0m20s/100m')
      end
    end

    describe '#pace_per_100_yards_s' do
      it 'formats pace as min/100yd' do
        expect(lap.pace_per_100_yards_s).to match(%r{\d+m\d+s/100yd})
      end

      it 'converts correctly' do
        # avg_speed is 4.96999979019165 m/s
        # 91.44 / (4.96999979019165 * 60) = 0.30677286 min/100yd
        # 0 minutes 18 seconds
        expect(lap.pace_per_100_yards_s).to eq('0m18s/100yd')
      end
    end
  end

  describe 'edge cases' do
    let(:zero_speed_lap) { Tcx::Types::Lap.new }
    let(:negative_speed_lap) { Tcx::Types::Lap.new }

    before do
      # Mock average_speed method to return specific values
      allow(zero_speed_lap).to receive(:average_speed).and_return(0)
      allow(negative_speed_lap).to receive(:average_speed).and_return(-5.0)
    end

    describe 'with zero speed' do
      it 'returns nil for formatted strings' do
        expect(zero_speed_lap.average_speed_kilometer_per_hour_s).to be_nil
        expect(zero_speed_lap.average_speed_miles_per_hour_s).to be_nil
        expect(zero_speed_lap.average_speed_s).to be_nil
        expect(zero_speed_lap.pace_per_kilometer_s).to be_nil
        expect(zero_speed_lap.pace_per_mile_s).to be_nil
        expect(zero_speed_lap.pace_per_100_meters_s).to be_nil
        expect(zero_speed_lap.pace_per_100_yards_s).to be_nil
      end

      it 'returns 0 for average_speed_meters_per_second' do
        expect(zero_speed_lap.average_speed_meters_per_second).to eq(0)
      end
    end

    describe 'with negative speed' do
      it 'returns nil for formatted strings' do
        expect(negative_speed_lap.average_speed_kilometer_per_hour_s).to be_nil
        expect(negative_speed_lap.average_speed_miles_per_hour_s).to be_nil
        expect(negative_speed_lap.average_speed_s).to be_nil
        expect(negative_speed_lap.pace_per_kilometer_s).to be_nil
        expect(negative_speed_lap.pace_per_mile_s).to be_nil
        expect(negative_speed_lap.pace_per_100_meters_s).to be_nil
        expect(negative_speed_lap.pace_per_100_yards_s).to be_nil
      end

      it 'returns negative value for average_speed_meters_per_second' do
        expect(negative_speed_lap.average_speed_meters_per_second).to eq(-5.0)
      end
    end
  end

  describe 'conversion accuracy' do
    let(:exact_speed_lap) { Tcx::Types::Lap.new }

    before do
      # 5 m/s = 18 km/h = 11.18 mph
      allow(exact_speed_lap).to receive(:average_speed).and_return(5.0)
    end

    it 'converts 5 m/s to 18 km/h' do
      expect(exact_speed_lap.average_speed_kilometer_per_hour_s).to eq('18.0km/h')
    end

    it 'converts 5 m/s to 11.2 mph' do
      expect(exact_speed_lap.average_speed_miles_per_hour_s).to eq('11.2mph')
    end

    it 'converts 5 m/s to 3m20s/km pace' do
      # 1000 / (5 * 60) = 3.333... minutes = 3:20
      expect(exact_speed_lap.pace_per_kilometer_s).to eq('3m20s/km')
    end

    it 'converts 5 m/s to 5m22s/mi pace' do
      # 1609.344 / (5 * 60) = 5.3644... minutes = 5:22
      expect(exact_speed_lap.pace_per_mile_s).to eq('5m22s/mi')
    end

    it 'converts 5 m/s to 0m20s/100m pace' do
      # 100 / (5 * 60) = 0.333... minutes = 0:20
      expect(exact_speed_lap.pace_per_100_meters_s).to eq('0m20s/100m')
    end

    it 'converts 5 m/s to 0m18s/100yd pace' do
      # 91.44 / (5 * 60) = 0.3048 minutes = 0:18
      expect(exact_speed_lap.pace_per_100_yards_s).to eq('0m18s/100yd')
    end
  end
end
