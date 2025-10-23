# frozen_string_literal: true

require 'tcx'

path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'tcx', 'multiple_running_activities.tcx')
tcx = Tcx.load_file(path)

puts "- #{File.basename(path)}: #{tcx.author.name}"
tcx.activities.each do |activity|
  puts "  - id: #{activity.id}"
  puts "    sport: #{activity.sport}"
  puts "    laps: #{activity.laps.count}, start=#{activity.laps.first.start_time}, end=#{activity.laps.last.start_time + activity.laps.last.total_time_seconds}"
end
