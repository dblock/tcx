# frozen_string_literal: true

# Brighton Beach Course Example
#
# This example demonstrates working with TCX course files. Courses are predefined
# routes with GPS tracks that can be used for navigation or training.
#
# The Brighton Beach course is a popular cycling/running route with detailed GPS
# trackpoints showing the exact path to follow.
#
# This example shows:
# - Loading a course file
# - Accessing course metadata (name, tracks)
# - Counting trackpoints in each GPS track
# - Writing the course to a new file

require 'tcx'
require 'tmpdir'

# Build path to the Brighton Beach course file
path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'courses', 'brighton-beach.tcx')

puts 'Brighton Beach Course Example'
puts '=' * 50
puts
puts "Loading: #{File.basename(path)}"
puts "Size: #{File.size(path)} bytes"
puts

# Load the TCX file containing course data
tcx = Tcx.load_file(path)

# Display course information
# The file contains one course with detailed GPS tracks
puts 'Course Information:'
puts "  Courses in file: #{tcx.courses.count}"
puts

# Iterate through all courses in the file
# Each course can contain multiple GPS tracks (though typically just one)
tcx.courses.each_with_index do |course, index|
  puts "Course #{index + 1}:"
  puts "  Name: #{course.name}"
  puts "  Tracks: #{course.tracks.count}"

  # Each track contains a series of trackpoints (GPS coordinates)
  # The Brighton Beach course has 2402 trackpoints defining the route
  course.tracks.each_with_index do |track, track_index|
    puts "    Track #{track_index + 1}: #{track.trackpoints.count} trackpoints"
  end
  puts
end

# Write the course to a temporary file
# This demonstrates the library's ability to read and write TCX files
# The output file will be identical to the input file (round-trip XML)
puts 'Writing to File:'
target_path = File.join(Dir.tmpdir, 'brighton-beach.tcx')
tcx.dump(target_path)
puts "  Output: #{target_path}"
puts "  Size: #{File.size(target_path)} bytes"
puts
puts "Success! Course data written with #{tcx.courses.first.tracks.first.trackpoints.count} trackpoints preserved."
