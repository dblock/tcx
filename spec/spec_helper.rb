# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'rspec'
require 'tcx'
require 'tmpdir'
require 'fileutils'
require 'rspec/temp_dir'
require 'super_diff/rspec'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each do |file|
  require file
end
