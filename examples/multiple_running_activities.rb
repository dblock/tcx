# frozen_string_literal: true

# Multiple Running Activities Example
#
# This example demonstrates working with TCX files containing multiple activities.
# A single TCX file can contain data from multiple workouts, which is common when
# exporting activity history from fitness platforms like Garmin Connect or Strava.
#
# This example shows:
# - Loading a file with multiple activities
# - Accessing author/creator information
# - Iterating through multiple activities
# - Accessing activity metadata (ID, sport, laps, timestamps)
# - Calculating activity start and end times from lap data
# - Writing the complete file to a new location

require 'tcx'
require 'tmpdir'

# Build path to the test file containing multiple running activities
path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'running', 'multiple_running_activities.tcx')

puts 'Multiple Running Activities Example'
puts '=' * 50
puts
puts "Loading: #{File.basename(path)}"
puts "Size: #{File.size(path)} bytes"
puts

# Load the TCX file
# This file contains 2 running activities from the same author
tcx = Tcx.load_file(path)

# Display file-level information
# TCX files can contain author information identifying who created the activities
puts 'File Information:'
puts "  Author: #{tcx.author.name}"
puts "  Activities: #{tcx.activities.count}"
puts

# Iterate through all activities in the file
# Each activity represents a separate workout session
tcx.activities.each_with_index do |activity, index|
  puts "Activity #{index + 1}:"

  # Activity ID is typically the start timestamp
  puts "  ID: #{activity.id}"

  # Sport type (Running, Biking, Other, etc.)
  puts "  Sport: #{activity.sport}"

  # Lap information
  # Activities are divided into laps, each with its own start time and duration
  # Here we calculate the total activity timespan from first lap start to last lap end
  lap_count = activity.laps.count
  start_time = activity.laps.first.start_time
  end_time = activity.laps.last.start_time + activity.laps.last.total_time_seconds

  puts "  Laps: #{lap_count}"
  puts "  Start Time: #{start_time}"
  puts "  End Time: #{end_time}"
  puts
end

# Write all activities to a new file
# The dump method preserves all activities and their complete data
puts 'Writing to File:'
target_path = File.join(Dir.tmpdir, 'multiple_running_activities2.tcx')
tcx.dump(target_path)
puts "  Output: #{target_path}"
puts "  Size: #{File.size(target_path)} bytes"
puts
puts "Success! File written with all #{tcx.activities.count} activities preserved."
