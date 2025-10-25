# frozen_string_literal: true

require 'hashie'
require 'time'
require 'ruby-enum'
require 'nokogiri'
require 'forwardable'

require_relative 'tcx/version'
require_relative 'tcx/mixins'
require_relative 'tcx/types'
require_relative 'tcx/extensions'
require_relative 'tcx/file'

# Tcx
#
# Ruby library for parsing and generating TCX (Training Center XML) files.
# TCX is Garmin's XML format for storing fitness and training data from GPS devices.
#
# This library provides:
#   - Full read support for TCX v2 format
#   - Complete write support (generate valid TCX files)
#   - Type-safe Ruby objects for all TCX types
#   - Support for Garmin's Activity Extension v2
#   - Round-trip XML parsing and generation
#
# ## Quick Start
#
# Load a TCX file from disk:
#   file = Tcx.load_file('activity.tcx')
#   file.activities.each { |a| puts a.sport }
#
# Parse TCX from a string:
#   database = Tcx.load(xml_string)
#   puts database.activities.first.distance_meters
#
# Create a new TCX file:
#   file = Tcx::File.new
#   file.database.activities = [...]
#   file.dump('output.tcx')
#
# ## Supported Activity Types
#
# - Running, cycling, swimming
# - Multisport (triathlons, duathlons)
# - Walking, hiking, cross-country skiing
# - Stand-up paddleboarding (SUP)
# - Any other GPS-tracked activity
#
# ## Key Classes
#
# - {Tcx::Types::Database} - Root container for all TCX data
# - {Tcx::Types::Activity} - Individual workout/activity
# - {Tcx::Types::Lap} - Lap within an activity
# - {Tcx::Types::Trackpoint} - GPS point with sensor data
# - {Tcx::Types::Workout} - Structured workout plan
# - {Tcx::Types::Course} - Predefined route
#
# @see https://www8.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd TCX XSD Schema
# @see https://github.com/dblock/tcx TCX Ruby Library on GitHub
module Tcx
  # Load a TCX file from disk
  # @param path [String] path to TCX file
  # @return [Tcx::File] file object with parsed database
  # @example
  #   file = Tcx.load_file('activity.tcx')
  #   puts file.activities.count
  def self.load_file(path)
    Tcx::File.new(path)
  end

  # Parse TCX data from a string
  # @param data [String] TCX XML data
  # @return [Tcx::Types::Database] parsed database object
  # @example
  #   xml = File.read('activity.tcx')
  #   database = Tcx.load(xml)
  #   puts database.activities.first.sport
  def self.load(data)
    Tcx::Types::Database.load(data)
  end
end
