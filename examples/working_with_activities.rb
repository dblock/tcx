# frozen_string_literal: true

# Working with Activities Example
#
# Demonstrates detailed activity analysis:
# - Accessing basic metrics
# - Iterating through GPS data (trackpoints)
# - Accessing extension data (speed, cadence, power)

require 'tcx'

# Load a TCX file with detailed GPS data
path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'running', 'running_activity_1.tcx')
file = Tcx.load_file(path)
activity = file.activities.first

puts 'Working with Activities Example'
puts '=' * 50
puts

# Basic metrics
puts 'Activity Details:'
puts "  Sport: #{activity.sport}"
puts "  ID: #{activity.id}"

distance = activity.distance_meters
puts "  Total Distance: #{activity.distance_meters_s} / #{activity.distance_kilometers_s} / #{activity.distance_miles_s}" if distance

time = activity.total_time_seconds
puts "  Total Time: #{time}s" if time

calories = activity.calories
puts "  Total Calories: #{calories}" if calories

avg_hr = activity.average_heart_rate_bpm
puts "  Average HR: #{avg_hr} bpm" if avg_hr

max_hr = activity.maximum_heart_rate_bpm
puts "  Max HR: #{max_hr} bpm" if max_hr
puts

# Access GPS data from first lap
lap = activity.laps.first
puts 'First Lap GPS Data:'
puts "  Lap Distance: #{lap.distance_meters}m"
puts "  Lap Time: #{lap.total_time_seconds}s"
puts

track = lap.tracks.first
puts '  Showing first 5 trackpoints:'
track.trackpoints.first(5).each_with_index do |point, index|
  puts "  #{index + 1}. Time: #{point.time}"

  puts "     Position: #{point.position.latitude_degrees}, #{point.position.longitude_degrees}" if point.position

  puts "     Heart Rate: #{point.heart_rate_bpm} bpm" if point.heart_rate_bpm
  puts "     Altitude: #{point.altitude_meters}m" if point.altitude_meters
  puts "     Distance: #{point.distance_meters}m" if point.distance_meters

  # Extension data (speed, cadence, power)
  if point.extensions&.TPX
    puts "     Speed: #{point.extensions.TPX.speed} m/s" if point.extensions.TPX.speed
    puts "     Run Cadence: #{point.extensions.TPX.run_cadence} steps/min" if point.extensions.TPX.run_cadence
    puts "     Watts: #{point.extensions.TPX.watts}W" if point.extensions.TPX.watts
  end
  puts
end

# Lap extension data
if lap.extensions&.LX
  puts 'Lap Extension Data:'
  puts "  Average Speed: #{lap.extensions.LX.avg_speed} m/s" if lap.extensions.LX.avg_speed
  puts "  Steps: #{lap.extensions.LX.steps}" if lap.extensions.LX.steps
  puts "  Average Run Cadence: #{lap.extensions.LX.avg_run_cadence} steps/min" if lap.extensions.LX.avg_run_cadence
  puts "  Max Run Cadence: #{lap.extensions.LX.max_run_cadence} steps/min" if lap.extensions.LX.max_run_cadence
end
