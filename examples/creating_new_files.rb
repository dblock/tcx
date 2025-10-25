# frozen_string_literal: true

# Creating New TCX Files Example
#
# Demonstrates creating TCX files from scratch:
# - Creating a new empty database
# - Building activity data programmatically
# - Writing to disk

require 'tcx'
require 'tmpdir'
require 'time'

puts 'Creating New TCX Files Example'
puts '=' * 50
puts

# Create a new empty database
file = Tcx::File.new

puts 'Created new empty database'
puts

# NOTE: The TCX library currently focuses on reading and parsing existing files.
# Creating complex activities from scratch requires building the complete object
# hierarchy including laps, tracks, and trackpoints.

# For demonstration, let's show how to access the database structure
puts 'Database structure:'
puts "  Activities: #{file.database.activities&.count || 0}"
puts "  Workouts: #{file.database.workouts&.count || 0}"
puts "  Courses: #{file.database.courses&.count || 0}"
puts

# Example of the object hierarchy needed to create an activity:
puts 'To create a new activity, you would need to build:'
puts '  1. Activity object with sport, id, and lap array'
puts '  2. Lap objects with start_time, distance, time, and track array'
puts '  3. Track objects with trackpoint array'
puts '  4. Trackpoint objects with time, position, heart_rate, etc.'
puts

# For practical use cases, it's recommended to:
puts 'Recommended approach for creating new TCX files:'
puts '  1. Load an existing TCX file as a template'
puts '  2. Modify the data as needed'
puts '  3. Write to a new file'
puts

# Example: Loading and modifying an existing file
template_path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'running', 'running_activity_1.tcx')
template = Tcx.load_file(template_path)

puts 'Loaded template activity:'
puts "  Sport: #{template.activities.first.sport}"
distance = template.activities.first.distance_meters
puts "  Distance: #{distance}m" if distance
puts

# Modify the template
template.activities.first.sport = :biking
template.activities.first.id = Time.now

puts 'Modified template:'
puts "  Sport: #{template.activities.first.sport}"
puts "  ID: #{template.activities.first.id}"
puts

# Write to a new file
output_path = File.join(Dir.tmpdir, 'new_activity.tcx')
template.dump(output_path)

puts "Created new TCX file: #{output_path}"
puts "File size: #{File.size(output_path)} bytes"
puts

# Verify the new file
verification = Tcx.load_file(output_path)
puts 'Verification:'
puts "  Sport: #{verification.activities.first.sport}"
puts "  ID: #{verification.activities.first.id}"
puts

puts 'Success! Created a new TCX file based on a template.'
