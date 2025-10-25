# frozen_string_literal: true

# Quick Start Example
#
# Demonstrates basic usage of the TCX library:
# - Loading a TCX file
# - Accessing activities and their metrics
# - Iterating through laps

require 'tcx'

# Load a TCX file
path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'running', 'multiple_running_activities.tcx')
file = Tcx.load_file(path)

puts 'Quick Start Example'
puts '=' * 50
puts

# Access activities
file.activities.each_with_index do |activity, index|
  puts "Activity #{index + 1}:"
  puts "  Sport: #{activity.sport}"

  distance = activity.distance_meters
  puts "  Distance: #{distance}m (#{activity.distance_kilometers}km / #{activity.distance_miles_s})" if distance

  time = activity.total_time_seconds
  puts "  Time: #{time}s" if time

  hr = activity.average_heart_rate_bpm
  puts "  Average HR: #{hr} bpm" if hr
  puts

  # Access laps
  activity.laps.each_with_index do |lap, lap_index|
    puts "  Lap #{lap_index + 1}:"
    puts "    Distance: #{lap.distance_meters}m"
    puts "    Time: #{lap.total_time_seconds}s"

    lap_hr = lap.average_heart_rate_bpm&.to_i
    puts "    Average HR: #{lap_hr} bpm" if lap_hr
  end
  puts
end
