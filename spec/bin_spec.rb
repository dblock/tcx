# frozen_string_literal: true

require 'spec_helper'
require 'open3'

describe 'Bin' do
  let(:bin_dir) { File.join(File.dirname(__FILE__), '../bin') }
  let(:lib_dir) { File.join(File.dirname(__FILE__), '../lib') }

  describe 'dump_and_diff.rb' do
    it 'executes without errors when given a TCX file' do
      script_path = File.join(bin_dir, 'dump_and_diff.rb')
      test_file = File.join(File.dirname(__FILE__), 'data/running/running_activity_1.tcx')
      stdout, stderr, status = Open3.capture3("ruby -I#{lib_dir} #{script_path} #{test_file}")

      expect(status.success?).to be(true), -> { "Script failed with output:\nSTDOUT:\n#{stdout}\nSTDERR:\n#{stderr}" }
      expect(stdout).to include('Success!')
    end
  end
end
