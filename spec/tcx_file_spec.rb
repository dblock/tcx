# frozen_string_literal: true

require 'spec_helper'

describe Tcx::File do
  context 'with a file path' do
    let(:file_path) { File.join(File.dirname(__FILE__), 'data', 'tcx', 'multiple_running_activities.tcx') }
    let(:tcx_file) { described_class.new(file_path) }

    describe '#initialize' do
      it 'accepts a file path' do
        expect(tcx_file.file_path).to eq file_path
      end
    end

    describe '#database' do
      it 'returns a Tcx::Database instance' do
        expect(tcx_file.database).to be_a Tcx::Database
      end

      it 'memoizes the database instance' do
        expect(tcx_file.database).to be tcx_file.database
      end

      it 'parses the TCX file correctly' do
        expect(tcx_file.activities.count).to eq 2
      end
    end

    describe 'delegation to database' do
      %i[activities folders workouts courses author].each do |method|
        describe method.to_s do
          it "delegates to database.#{method}" do
            expect(tcx_file.send(method)).to eq tcx_file.database.send(method)
          end
        end
      end
    end

    describe '#dump' do
      include_context 'uses temp dir'

      let(:temp_file) { File.join(temp_dir, 'test_tcx_output.tcx') }

      it 'delegates to database.dump' do
        expect(tcx_file.database).to receive(:dump).with(temp_file)
        tcx_file.dump(temp_file)
      end

      it 'writes XML output to the specified file' do
        tcx_file.dump(temp_file)
        content = File.read(temp_file)
        expect(content).to include('<?xml version="1.0" encoding="UTF-8"?>')
        expect(content).to include('TrainingCenterDatabase')
      end

      it 'writes content that matches original file' do
        tcx_file.dump(temp_file)
        expect(FileUtils.compare_file(file_path, temp_file)).to be_truthy
      end
    end
  end

  context 'without a file path' do
    let(:tcx_file) { described_class.new }

    it 'can be initialized without a file path' do
      expect(tcx_file.file_path).to be_nil
      expect(tcx_file.database).to be_a Tcx::Database
    end
  end

  context 'with multiple running activities' do
    let(:tcx) { described_class.new(File.join(File.dirname(__FILE__), 'data', 'tcx', 'multiple_running_activities.tcx')) }

    it 'has the correct number of activities' do
      expect(tcx.activities.count).to eq 2
    end

    context 'the first activity' do
      let(:activity) { tcx.activities.first }

      it 'has the correct properties' do
        expect(activity.id).to eq '2014-12-26T10:00:39.000Z'
        expect(activity.sport).to eq 'Running'
        expect(activity.notes).to be_nil
      end

      it 'has the correct number of laps' do
        expect(activity.laps.count).to eq 15
      end

      describe '.laps' do
        let(:lap) { activity.laps.first }

        it 'has the correct id' do
          expect(lap.start_time).to eq Time.parse('2014-12-26 10:00:39 +0000')
          expect(lap.total_time_seconds).to eq 201.0
          expect(lap.distance_meters).to eq 1000.0
          expect(lap.maximum_speed).to eq 6.105999946594238
          expect(lap.calories).to eq 66
          expect(lap.average_heart_rate_bpm).to eq 167
          expect(lap.maximum_heart_rate_bpm).to eq 179
          expect(lap.intensity).to eq 'Active'
          expect(lap.cadence).to be_nil
          expect(lap.trigger_method).to eq 'Manual'
          expect(lap.notes).to be_nil
          expect(lap.extensions.keys).to eq(%w[LX])
          expect(lap.extensions.LX.avg_speed).to eq(4.96999979019165)
          # TODO: expect(lap.avg_speed).to eq(4.96999979019165)
          expect(lap.tracks.count).to eq 1
        end

        describe '.tracks' do
          let(:track) { lap.tracks.first }

          it 'has the correct properties' do
            expect(track).to be_a Tcx::Track
            expect(track.trackpoints.count).to eq 78
          end

          describe '.trackpoints' do
            let(:trackpoint) { track.trackpoints.first }

            it 'has the correct properties' do
              expect(trackpoint).to be_a Tcx::Trackpoint
              expect(trackpoint.time).to eq Time.parse('2014-12-26 10:00:39 +0000')
              expect(trackpoint.altitude_meters).to eq 279.0
              expect(trackpoint.distance_meters).to eq 0.0
              expect(trackpoint.heart_rate_bpm).to eq 113
              expect(trackpoint.cadence).to be_nil
              expect(trackpoint.sensor_state).to be_nil
              expect(trackpoint.extensions.keys).to eq(%w[TPX])
              expect(trackpoint.extensions.TPX.speed).to eq(0.0)
            end

            describe '.position' do
              let(:position) { trackpoint.position }

              it 'has the correct properties' do
                expect(position).to be_a Tcx::Position
                expect(position.latitude_degrees).to eq 46.09344659373164
                expect(position.longitude_degrees).to eq 14.678033776581287
              end
            end
          end
        end
      end

      describe '.creator' do
        let(:creator) { activity.creator }

        it 'has the correct properties' do
          expect(creator).to be_a Tcx::AbstractSource
          expect(creator.name).to eq 'Garmin Forerunner 910XT'
          expect(creator.product_id).to eq '1328'
          expect(creator.unit_id).to eq '3881644365'
        end

        describe '.version' do
          let(:version) { creator.version }

          it 'has the correct properties' do
            expect(version).to be_a Tcx::Version
            expect(version.version_major).to eq 3
            expect(version.version_minor).to eq 0
            expect(version.build_major).to eq 0
            expect(version.build_minor).to eq 0
          end
        end
      end
    end
  end
end
