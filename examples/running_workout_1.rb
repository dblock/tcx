# frozen_string_literal: true

require 'tcx'
require 'tmpdir'

path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'running', 'running_workout_1.tcx')
puts "Loading #{path}, #{File.size(path)} byte(s)"
puts
tcx = Tcx.load_file(path)

puts "- #{File.basename(tcx.file_path)}: #{tcx.author.name}"
tcx.activities.each do |activity|
  puts "  - id: #{activity.id}"
  puts "    sport: #{activity.sport}"
  puts "    laps: #{activity.laps.count}, start=#{activity.laps.first.start_time}, end=#{activity.laps.last.start_time + activity.laps.last.total_time_seconds}"
end

puts
target_path = File.join(Dir.tmpdir, 'running_workout_1.tcx')
tcx.dump(target_path)
puts "Wrote #{target_path}, #{File.size(target_path)} byte(s)"
