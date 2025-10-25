# frozen_string_literal: true

require 'spec_helper'

describe Tcx::File do
  context 'with a file path' do
    let(:file_path) do
      File.join(File.dirname(__FILE__), '../data/running/multiple_running_activities.tcx')
    end

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

      context 'when dumped' do
        before do
          tcx_file.dump(temp_file)
        end

        let(:dumped_xml) { File.read(temp_file) }

        it 'writes XML output to the specified file' do
          expect(dumped_xml).to include('<?xml version="1.0" encoding="UTF-8"?>')
          expect(dumped_xml).to include('TrainingCenterDatabase')
        end

        it 'writes content that matches original file' do
          expect(File.read(file_path)).to eq dumped_xml
        end
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
    let(:tcx) do
      described_class.new(File.join(File.dirname(__FILE__), '../data/running/multiple_running_activities.tcx'))
    end

    it 'has the correct number of activities' do
      expect(tcx.activities.count).to eq 2
    end

    describe 'the first activity' do
      let(:activity) { tcx.activities.first }

      it 'has the correct properties' do
        expect(activity.id).to eq '2014-12-26T10:00:39Z'
        expect(activity.sport).to eq 'Running'
        expect(activity.notes).to be_nil
        expect(activity.total_time_seconds).to eq 3270.0
        expect(activity.end_time).to eq Time.parse('2014-12-26 10:55:10 +0000')
        expect(activity.distance_meters).to eq 14_332.28
        expect(activity.maximum_speed).to eq 6.247000217437744
        expect(activity.calories).to eq 1182
        expect(activity.average_heart_rate_bpm).to eq 177.06666666666666
        expect(activity.maximum_heart_rate_bpm).to eq 181
        expect(activity.average_speed).to eq 4.382960244648318
        expect(activity.max_bike_cadence).to be_nil
        expect(activity.max_run_cadence).to be_nil
        expect(activity.steps).to eq 0
        expect(activity.max_watts).to be_nil
      end

      it 'has the correct number of laps' do
        expect(activity.laps.count).to eq 15
      end

      describe '.laps' do
        let(:lap) { activity.laps.first }

        it 'has the correct properties' do
          expect(lap.start_time).to eq Time.parse('2014-12-26 10:00:39 +0000')
          expect(lap.total_time_seconds).to eq 201.0
          expect(lap.end_time).to eq Time.parse('2014-12-26 10:04:00 +0000')
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
          expect(lap.tracks.count).to eq 1
          expect(lap.extensions.LX.avg_speed).to eq(4.96999979019165)
        end

        it 'delegates LX' do
          expect(lap.avg_speed).to eq(4.96999979019165)
          expect(lap.max_bike_cadence).to be_nil
          expect(lap.avg_run_cadence).to be_nil
          expect(lap.max_run_cadence).to be_nil
          expect(lap.steps).to be_nil
          expect(lap.avg_watts).to be_nil
          expect(lap.max_watts).to be_nil
        end

        it 'delegates TPX' do
          expect(lap.speed).to be_nil
          expect(lap.run_cadence).to be_nil
          expect(lap.watts).to be_nil
          expect(lap.cadence_sensor).to be_nil
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

  context 'with a course' do
    let(:tcx) do
      described_class.new(File.join(File.dirname(__FILE__), '../data/courses/brighton-beach.tcx'))
    end

    it 'contains a course' do
      expect(tcx.courses.count).to eq 1
    end

    context 'the course' do
      let(:course) { tcx.courses.first }

      it 'has the correct properties' do
        expect(course.name).to eq 'Brighton Beach'
        expect(course.laps.count).to eq 1
        expect(course.tracks.count).to eq 1
        expect(course.course_points).to be_nil
        expect(course.notes).to be_nil
        expect(course.creator).to be_nil
      end

      context 'first lap' do
        let(:lap) { course.laps.first }

        it 'is a lap' do
          expect(lap).to be_a Tcx::CourseLap
          expect(lap.total_time_seconds).to eq(0.0)
          expect(lap.distance_meters).to eq(29_320.969880372675)
          expect(lap.begin_position).to be_a Tcx::Position
          expect(lap.begin_position.latitude_degrees).to eq(40.75622691)
          expect(lap.begin_position.longitude_degrees).to eq(-73.9973099)
          expect(lap.end_position).to be_a Tcx::Position
          expect(lap.end_position.latitude_degrees).to eq(40.57761895)
          expect(lap.end_position.longitude_degrees).to eq(-73.9612219)
          expect(lap.intensity).to eq(Tcx::Intensity.active)
        end
      end

      context 'first track' do
        let(:track) { course.tracks.first }

        it 'is a track' do
          expect(track).to be_a Tcx::Track
          expect(track.trackpoints.count).to eq 2402
        end

        context 'first track point' do
          let(:trackpoint) { track.trackpoints.first }

          it 'is a trackpoint' do
            expect(trackpoint).to be_a Tcx::Trackpoint
            expect(trackpoint.time).to eq Time.parse('2025-10-24T17:59:04Z')
            expect(trackpoint.position.latitude_degrees).to eq 40.75622691
            expect(trackpoint.position.longitude_degrees).to eq(-73.9973099)
            expect(trackpoint.position).to be_a Tcx::Position
            expect(trackpoint.altitude_meters).to eq 15.0
            expect(trackpoint.distance_meters).to eq 0.0
          end
        end
      end
    end
  end

  context 'with a workout' do
    let(:tcx) do
      described_class.new(File.join(File.dirname(__FILE__), '../data/workouts/simple_workout_1.tcx'))
    end

    it 'contains a workout' do
      expect(tcx.workouts.count).to eq 1
    end

    context 'the workout' do
      let(:workout) { tcx.workouts.first }

      it 'has the correct properties' do
        expect(workout.name).to eq 'Run Mon 11/11'
        expect(workout.sport).to eq 'Running'
        expect(workout.steps.count).to eq 3
        expect(workout.creator).to be_nil
        expect(workout.notes).to start_with '5 min walk warm-up'
        expect(workout.extensions).to be_nil
      end

      context 'first step' do
        let(:step) { workout.steps.first }

        it 'is a lap' do
          expect(step).to be_a Tcx::Step
          expect(step.step_id).to eq '1'
          expect(step.name).to eq 'Warm Up'
          expect(step.duration.seconds).to eq 300
          expect(step.intensity).to eq 'Resting'
          expect(step.target).to be_a Tcx::None
        end
      end
    end
  end
end
