# frozen_string_literal: true

# Working with Courses Example
#
# Demonstrates course analysis:
# - Accessing course metadata
# - Iterating through course points (waypoints)
# - Understanding course laps and tracks

require 'tcx'

# Load a TCX file with course data
path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'courses', 'brighton-beach.tcx')
file = Tcx.load_file(path)

puts 'Working with Courses Example'
puts '=' * 50
puts

# Access courses
if file.courses&.any?
  file.courses.each_with_index do |course, index|
    puts "Course #{index + 1}:"
    puts "  Name: #{course.name}"
    puts "  Notes: #{course.notes}" if course.notes
    puts

    # Course laps
    if course.laps&.any?
      puts '  Course Laps:'
      course.laps.each_with_index do |lap, lap_index|
        puts "    Lap #{lap_index + 1}:"
        puts "      Distance: #{lap.distance_meters}m" if lap.distance_meters
        puts "      Total Time: #{lap.total_time_seconds}s" if lap.total_time_seconds

        puts "      Start: #{lap.begin_position.latitude_degrees}, #{lap.begin_position.longitude_degrees}" if lap.begin_position

        puts "      End: #{lap.end_position.latitude_degrees}, #{lap.end_position.longitude_degrees}" if lap.end_position

        puts "      Intensity: #{lap.intensity}" if lap.intensity
        puts
      end
    end

    # Course points (aid stations, turns, etc.)
    if course.course_points&.any?
      puts '  Course Points (Waypoints):'
      course.course_points.each_with_index do |point, point_index|
        puts "    #{point_index + 1}. #{point.name} (#{point.point_type})"

        puts "       Location: #{point.position.latitude_degrees}, #{point.position.longitude_degrees}" if point.position

        puts "       Altitude: #{point.altitude_meters}m" if point.altitude_meters
        puts "       Notes: #{point.notes}" if point.notes
        puts
      end
    end

    # GPS tracks
    next unless course.tracks&.any?

    puts '  GPS Tracks:'
    course.tracks.each_with_index do |track, track_index|
      puts "    Track #{track_index + 1}: #{track.trackpoints.count} trackpoints"

      # Show first and last trackpoint
      if track.trackpoints.any?
        first = track.trackpoints.first
        last = track.trackpoints.last

        puts "      Start: #{first.position.latitude_degrees}, #{first.position.longitude_degrees}" if first.position

        puts "      End: #{last.position.latitude_degrees}, #{last.position.longitude_degrees}" if last.position
      end
      puts
    end
  end
else
  puts 'No courses found in this file.'
  puts 'Try running this example with spec/data/courses/brighton-beach.tcx'
end
