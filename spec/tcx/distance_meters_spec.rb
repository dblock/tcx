# frozen_string_literal: true

require 'spec_helper'

describe Tcx::DistanceMeters do
  let(:file_path) { File.join(File.dirname(__FILE__), '../data/running/running_activity_1.tcx') }
  let(:tcx) { Tcx.load_file(file_path) }
  let(:activity) { tcx.activities.first }
  let(:lap) { activity.laps.first }
  let(:trackpoint) { lap.tracks.first.trackpoints.first }

  describe 'Activity' do
    describe '#distance_meters' do
      it 'returns the distance in meters' do
        expect(activity.distance_meters).to be_a(Float)
        expect(activity.distance_meters).to be > 0
      end
    end

    describe '#distance_feet' do
      it 'converts meters to feet' do
        meters = activity.distance_meters
        expect(activity.distance_feet).to eq(meters * 3.28084)
      end
    end

    describe '#distance_miles' do
      it 'converts meters to miles' do
        meters = activity.distance_meters
        expect(activity.distance_miles).to eq(meters * 0.00062137)
      end
    end

    describe '#distance_miles_s' do
      it 'formats distance as miles string' do
        expect(activity.distance_miles_s).to match(/\d+(\.\d+)?mi/)
      end
    end

    describe '#distance_yards' do
      it 'converts meters to yards' do
        meters = activity.distance_meters
        expect(activity.distance_yards).to eq(meters * 1.09361)
      end
    end

    describe '#distance_yards_s' do
      it 'formats distance as yards string' do
        expect(activity.distance_yards_s).to match(/\d+(\.\d+)?yd/)
      end
    end

    describe '#distance_meters_s' do
      it 'formats distance as meters string' do
        expect(activity.distance_meters_s).to match(/\d+m/)
      end
    end

    describe '#distance_kilometers' do
      it 'converts meters to kilometers' do
        meters = activity.distance_meters
        expect(activity.distance_kilometers).to eq(meters / 1000)
      end
    end

    describe '#distance_kilometers_s' do
      it 'formats distance as kilometers string' do
        expect(activity.distance_kilometers_s).to match(/\d+(\.\d+)?km/)
      end
    end

    describe '#distance_s' do
      it 'returns the same as distance_kilometers_s' do
        expect(activity.distance_s).to eq(activity.distance_kilometers_s)
      end
    end
  end

  describe 'Lap' do
    describe '#distance_meters' do
      it 'returns the distance in meters' do
        expect(lap.distance_meters).to be_a(Float)
        expect(lap.distance_meters).to be > 0
      end
    end

    describe '#distance_kilometers' do
      it 'converts meters to kilometers' do
        meters = lap.distance_meters
        expect(lap.distance_kilometers).to eq(meters / 1000)
      end
    end

    describe '#distance_miles' do
      it 'converts meters to miles' do
        meters = lap.distance_meters
        expect(lap.distance_miles).to eq(meters * 0.00062137)
      end
    end

    describe '#distance_feet' do
      it 'converts meters to feet' do
        meters = lap.distance_meters
        expect(lap.distance_feet).to eq(meters * 3.28084)
      end
    end

    describe '#distance_yards' do
      it 'converts meters to yards' do
        meters = lap.distance_meters
        expect(lap.distance_yards).to eq(meters * 1.09361)
      end
    end

    describe '#distance_kilometers_s' do
      it 'formats distance as kilometers string' do
        expect(lap.distance_kilometers_s).to match(/\d+(\.\d+)?km/)
      end
    end

    describe '#distance_miles_s' do
      it 'formats distance as miles string' do
        expect(lap.distance_miles_s).to match(/\d+(\.\d+)?mi/)
      end
    end

    describe '#distance_meters_s' do
      it 'formats distance as meters string' do
        expect(lap.distance_meters_s).to match(/\d+m/)
      end
    end

    describe '#distance_yards_s' do
      it 'formats distance as yards string' do
        expect(lap.distance_yards_s).to match(/\d+(\.\d+)?yd/)
      end
    end

    describe '#distance_s' do
      it 'returns the same as distance_kilometers_s' do
        expect(lap.distance_s).to eq(lap.distance_kilometers_s)
      end
    end
  end

  describe 'Trackpoint' do
    describe '#distance_meters' do
      it 'returns the distance in meters' do
        expect(trackpoint.distance_meters).to be_a(Float)
        expect(trackpoint.distance_meters).to be >= 0
      end
    end

    describe '#distance_kilometers' do
      it 'converts meters to kilometers' do
        meters = trackpoint.distance_meters
        expect(trackpoint.distance_kilometers).to eq(meters / 1000)
      end
    end

    describe '#distance_miles' do
      it 'converts meters to miles' do
        meters = trackpoint.distance_meters
        expect(trackpoint.distance_miles).to eq(meters * 0.00062137)
      end
    end

    describe '#distance_feet' do
      it 'converts meters to feet' do
        meters = trackpoint.distance_meters
        expect(trackpoint.distance_feet).to eq(meters * 3.28084)
      end
    end

    describe '#distance_yards' do
      it 'converts meters to yards' do
        meters = trackpoint.distance_meters
        expect(trackpoint.distance_yards).to eq(meters * 1.09361)
      end
    end
  end

  describe 'CourseLap' do
    let(:course_file_path) { File.join(File.dirname(__FILE__), '../data/courses/brighton-beach.tcx') }
    let(:course_tcx) { Tcx.load_file(course_file_path) }
    let(:course) { course_tcx.courses.first }
    let(:course_lap) { course.laps.first }

    describe '#distance_meters' do
      it 'returns the distance in meters' do
        expect(course_lap.distance_meters).to be_a(Float)
        expect(course_lap.distance_meters).to be > 0
      end
    end

    describe '#distance_kilometers' do
      it 'converts meters to kilometers' do
        meters = course_lap.distance_meters
        expect(course_lap.distance_kilometers).to eq(meters / 1000)
      end
    end

    describe '#distance_miles' do
      it 'converts meters to miles' do
        meters = course_lap.distance_meters
        expect(course_lap.distance_miles).to eq(meters * 0.00062137)
      end
    end
  end

  describe 'edge cases' do
    let(:zero_distance_lap) { Tcx::Lap.new('DistanceMeters' => 0) }
    let(:negative_distance_lap) { Tcx::Lap.new('DistanceMeters' => -100) }

    describe 'with zero distance' do
      it 'returns nil for formatted strings' do
        expect(zero_distance_lap.distance_meters_s).to be_nil
        expect(zero_distance_lap.distance_kilometers_s).to be_nil
        expect(zero_distance_lap.distance_miles_s).to be_nil
        expect(zero_distance_lap.distance_yards_s).to be_nil
        expect(zero_distance_lap.distance_s).to be_nil
      end

      it 'returns 0 for numeric conversions' do
        expect(zero_distance_lap.distance_meters).to eq(0)
        expect(zero_distance_lap.distance_kilometers).to eq(0)
        expect(zero_distance_lap.distance_miles).to eq(0)
        expect(zero_distance_lap.distance_feet).to eq(0)
        expect(zero_distance_lap.distance_yards).to eq(0)
      end
    end

    describe 'with negative distance' do
      it 'returns nil for formatted strings' do
        expect(negative_distance_lap.distance_meters_s).to be_nil
        expect(negative_distance_lap.distance_kilometers_s).to be_nil
        expect(negative_distance_lap.distance_miles_s).to be_nil
        expect(negative_distance_lap.distance_yards_s).to be_nil
        expect(negative_distance_lap.distance_s).to be_nil
      end

      it 'returns negative values for numeric conversions' do
        expect(negative_distance_lap.distance_meters).to eq(-100)
        expect(negative_distance_lap.distance_kilometers).to eq(-0.1)
        expect(negative_distance_lap.distance_miles).to be < 0
        expect(negative_distance_lap.distance_feet).to be < 0
        expect(negative_distance_lap.distance_yards).to be < 0
      end
    end
  end

  describe 'conversion accuracy' do
    let(:exact_km_lap) { Tcx::Lap.new('DistanceMeters' => 5000) }

    it 'converts 5000m to 5km exactly' do
      expect(exact_km_lap.distance_kilometers).to eq(5.0)
    end

    it 'formats 5000m as "5km"' do
      expect(exact_km_lap.distance_kilometers_s).to eq('5km')
    end

    it 'converts 5000m to approximately 3.11 miles' do
      expect(exact_km_lap.distance_miles).to be_within(0.01).of(3.10686)
    end

    it 'formats 5000m as "3.11mi"' do
      expect(exact_km_lap.distance_miles_s).to eq('3.11mi')
    end

    it 'converts 5000m to approximately 16404 feet' do
      expect(exact_km_lap.distance_feet).to be_within(1).of(16_404.2)
    end

    it 'converts 5000m to approximately 5468 yards' do
      expect(exact_km_lap.distance_yards).to be_within(1).of(5468.05)
    end

    it 'formats 5000m as "5000m"' do
      expect(exact_km_lap.distance_meters_s).to eq('5000m')
    end

    it 'formats 5000m as "5468yd"' do
      expect(exact_km_lap.distance_yards_s).to eq('5468yd')
    end
  end
end
