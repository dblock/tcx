# frozen_string_literal: true

# Parsing XML Data Example
#
# Demonstrates working with TCX data in memory:
# - Parsing XML strings
# - Modifying TCX data
# - Generating XML output
# - Writing modified data to files

require 'tcx'
require 'tmpdir'

puts 'Parsing XML Data Example'
puts '=' * 50
puts

# Read XML data from file
path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'running', 'running_activity_1.tcx')
xml_string = File.read(path)

puts "Loaded XML: #{xml_string.length} bytes"
puts

# Parse XML string directly (no file object)
database = Tcx.load(xml_string)

puts 'Parsed Database:'
puts "  Activities: #{database.activities.count}"
puts "  Workouts: #{database.workouts&.count || 0}"
puts "  Courses: #{database.courses&.count || 0}"
puts

# Access and display original data
activity = database.activities.first
puts 'Original Activity:'
puts "  Sport: #{activity.sport}"

distance = activity.distance_meters
puts "  Distance: #{distance}m" if distance

time = activity.total_time_seconds
puts "  Time: #{time}s" if time
puts

# Modify the data
puts 'Modifying activity data...'
original_sport = activity.sport
activity.sport = :biking
puts "  Changed sport from #{original_sport} to #{activity.sport}"
puts

# Generate XML from modified data
modified_xml = database.to_xml
puts "Generated XML: #{modified_xml.length} bytes"
puts

# Write modified data to a new file
output_path = File.join(Dir.tmpdir, 'modified_activity.tcx')
database.dump(output_path)
puts "Wrote modified data to: #{output_path}"
puts "File size: #{File.size(output_path)} bytes"
puts

# Verify the modification
reloaded = Tcx.load_file(output_path)
reloaded_activity = reloaded.activities.first

puts 'Verification - reloaded activity:'
puts "  Sport: #{reloaded_activity.sport}"

distance = reloaded_activity.distance_meters
puts "  Distance: #{distance}m" if distance

time = reloaded_activity.total_time_seconds
puts "  Time: #{time}s" if time
puts

puts 'Success! The activity data was modified and written correctly.'
