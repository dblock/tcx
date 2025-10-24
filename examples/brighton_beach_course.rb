# frozen_string_literal: true

require 'tcx'
require 'tmpdir'

path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'courses', 'brighton-beach.tcx')
puts "Loading #{path}, #{File.size(path)} byte(s)"
puts
tcx = Tcx.load_file(path)

puts "- #{File.basename(tcx.file_path)}: #{tcx.courses.first.name}"
tcx.courses.each do |course|
  puts "  - name: #{course.name}"
  puts "    tracks: #{course.tracks.count}"
  course.tracks.each do |track|
    puts "    - trackpoints: #{track.trackpoints.count}"
  end
end

puts
target_path = File.join(Dir.tmpdir, 'brighton-beach.tcx')
tcx.dump(target_path)
puts "Wrote #{target_path}, #{File.size(target_path)} byte(s)"
