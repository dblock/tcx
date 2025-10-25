# frozen_string_literal: true

# Working with Workouts Example
#
# Demonstrates structured workout analysis:
# - Accessing workout metadata
# - Iterating through workout steps
# - Understanding step duration, intensity, and targets

require 'tcx'

# Load a TCX file with workout data
path = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'running', 'running_workout_1.tcx')
file = Tcx.load_file(path)

puts 'Working with Workouts Example'
puts '=' * 50
puts

# Access workouts
if file.workouts&.any?
  file.workouts.each_with_index do |workout, index|
    puts "Workout #{index + 1}:"
    puts "  Name: #{workout.name}" if workout.name
    puts "  Sport: #{workout.sport}"
    puts "  Number of Steps: #{workout.steps.count}"
    puts

    # Access workout steps
    workout.steps.each_with_index do |step, step_index|
      puts "  Step #{step_index + 1}:"
      puts "    Name: #{step.name}" if step.name
      puts "    Step ID: #{step.step_id}" if step.step_id

      # Duration
      if step.duration
        if step.duration.seconds
          puts "    Duration: #{step.duration.seconds}s (time-based)"
        elsif step.duration.meters
          puts "    Duration: #{step.duration.meters}m (distance-based)"
        elsif step.duration.calories
          puts "    Duration: #{step.duration.calories} calories"
        elsif step.duration.heart_rate
          puts '    Duration: Until HR threshold (HR-based)'
        end
      end

      # Intensity
      puts "    Intensity: #{step.intensity}" if step.intensity

      # Target
      if step.target
        if step.target.heart_rate_zone
          if step.target.heart_rate_zone.respond_to?(:number)
            puts "    Target: HR Zone #{step.target.heart_rate_zone.number}"
          elsif step.target.heart_rate_zone.respond_to?(:low)
            puts "    Target: HR #{step.target.heart_rate_zone.low}-#{step.target.heart_rate_zone.high} bpm"
          end
        elsif step.target.speed_zone
          puts '    Target: Speed Zone'
        elsif step.target.cadence
          puts '    Target: Cadence'
        end
      end

      # Repeat information (for Repeat steps)
      if step.respond_to?(:repetitions)
        puts "    Repetitions: #{step.repetitions}"
        puts "    Child Steps: #{step.child.count}" if step.child
      end

      puts
    end
  end
else
  puts 'No workouts found in this file.'
  puts 'This example works best with workout TCX files.'
end
