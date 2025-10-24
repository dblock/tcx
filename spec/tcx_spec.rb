# frozen_string_literal: true

require 'spec_helper'

describe Tcx do
  let(:tcx_files) { Dir.glob(File.join(File.dirname(__FILE__), 'data', '**', '*.tcx')) }

  describe '#load_file' do
    Dir.glob(File.join(File.dirname(__FILE__), 'data', '**', '*.tcx')).each do |tcx_file|
      describe Pathname.new(tcx_file).relative_path_from(Pathname.new(File.dirname(__FILE__)).parent).to_s do
        let(:tcx) { described_class.load_file(tcx_file) }

        it 'returns a file' do
          expect(tcx).to be_a Tcx::File
        end

        context 'when dumped' do
          include_context 'uses temp dir'

          let(:temp_file) { File.join(temp_dir, File.basename(tcx_file)) }

          before do
            tcx.dump(temp_file)
          end

          it 'writes an identical file' do
            expect(File.read(tcx_file)).to eq File.read(temp_file)
          end
        end
      end
    end
  end

  describe '#load' do
    let(:data) { File.read(File.join(File.dirname(__FILE__), 'data', 'running', 'multiple_running_activities.tcx')) }
    let(:tcx) { described_class.load(data) }

    it 'returns a database' do
      expect(tcx).to be_a Tcx::Database
    end

    it 'has the correct number of activities' do
      expect(tcx.activities.count).to eq 2
    end
  end
end
