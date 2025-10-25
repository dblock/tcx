# frozen_string_literal: true

require 'spec_helper'
require 'open3'

describe 'Examples' do
  let(:examples_dir) { File.join(File.dirname(__FILE__), '../examples') }
  let(:lib_dir) { File.join(File.dirname(__FILE__), '../lib') }

  # Dynamically generate specs for all example files
  Dir.glob(File.join(File.dirname(__FILE__), '../examples/*.rb')).each do |example_path|
    example_file = File.basename(example_path)

    describe example_file do
      it 'executes without errors' do
        stdout, stderr, status = Open3.capture3("ruby -I#{lib_dir} #{example_path}")

        expect(status.success?).to be(true), -> { "Example failed with output:\nSTDOUT:\n#{stdout}\nSTDERR:\n#{stderr}" }
      end
    end
  end
end
