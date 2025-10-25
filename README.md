# TCX

[![Gem Version](https://badge.fury.io/rb/tcx.svg)](https://badge.fury.io/rb/tcx)
[![Test](https://github.com/dblock/tcx/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/dblock/tcx/actions/workflows/test.yml)

A comprehensive Ruby library for reading and writing Garmin Training Center XML (.TCX) files.

## Features

- **Complete TCX v2 Support** - Full implementation of the [TCX schema](https://www8.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd)
- **Read & Write** - Parse existing TCX files and generate new ones
- **Type-Safe API** - Idiomatic Ruby objects for all TCX types
- **Extension Support** - Garmin's ActivityExtension v2 for speed, cadence, power, and steps
- **Distance & Speed Conversions** - Built-in conversions for distance and speed/pace metrics
- **Round-Trip XML** - Parse and regenerate identical TCX files
- **Comprehensive Documentation** - YARD documentation for all classes and methods

### Supported Data Types

- **Activities** - Running, cycling, swimming, multisport (triathlons), and other GPS-tracked workouts
- **Workouts** - Structured workout plans with steps, intervals, and targets
- **Courses** - Predefined routes with GPS tracks and waypoints
- **Laps & Trackpoints** - Detailed GPS data with heart rate, cadence, speed, altitude, and power
- **History & Organization** - Folder structures for organizing activities, workouts, and courses

### Why This Library?

Unlike other TCX libraries such as [tcx_rb](https://github.com/keithdoggett/tcx_rb) or [tcxread](https://github.com/firefly-cpp/tcxread), this library:

- Implements both read **and** write operations
- Supports the complete TCX schema including workouts, courses, and extensions
- Provides a more idiomatic Ruby API with full YARD documentation
- Maintains round-trip XML fidelity (parse → modify → write)
- Includes comprehensive test coverage with real-world TCX files

## Installation

Add to Gemfile.

```
gem 'tcx'
```

Run `bundle install`.

## Usage

### Quick Start

```ruby
require 'tcx'

# Load a TCX file
file = Tcx.load_file('activity.tcx')

# Access activities
file.activities.each do |activity|
  distance = activity.distance_meters
  time = activity.total_time_seconds
  puts "#{activity.sport}: #{distance}m in #{time}s" if distance && time

  # Access laps
  activity.laps.each do |lap|
    hr = lap.average_heart_rate_bpm&.to_i
    puts "  Lap: #{lap.distance_meters}m, HR: #{hr} bpm" if hr
  end
end
```

### Working with Activities

```ruby
file = Tcx.load_file('run.tcx')
activity = file.activities.first

# Basic metrics
activity.sport                  # => :running
activity.distance_meters        # => 5000.0
activity.total_time_seconds     # => 1500.0
activity.calories               # => 350
activity.average_heart_rate_bpm # => 155

# Distance unit conversions
activity.distance_kilometers    # => 5.0
activity.distance_miles         # => 3.10686
activity.distance_kilometers_s  # => "5km"
activity.distance_miles_s       # => "3.11mi"

# Speed and pace conversions
activity.average_speed                       # => 3.33 (calculated from distance/time)
activity.average_speed_kilometer_per_hour_s  # => "12.0km/h"
activity.average_speed_miles_per_hour_s      # => "7.5mph"
activity.pace_per_kilometer_s                # => "5m00s/km"
activity.pace_per_mile_s                     # => "8m03s/mi"

# Access GPS data
activity.laps.each do |lap|
  lap.tracks.each do |track|
    track.trackpoints.each do |point|
      puts "#{point.time}: #{point.position.latitude_degrees}, #{point.position.longitude_degrees}"
      puts "  HR: #{point.heart_rate_bpm}, Alt: #{point.altitude_meters}m"

      # Extension data (speed, cadence, power)
      if point.extensions&.TPX
        puts "  Speed: #{point.extensions.TPX.speed} m/s"
        puts "  Cadence: #{point.extensions.TPX.run_cadence} steps/min"
      end
    end
  end
end
```

### Working with Workouts

```ruby
file = Tcx.load_file('workout.tcx')
workout = file.workouts.first

workout.name    # => "5x1K Intervals"
workout.sport   # => :running

# Access workout steps
workout.steps.each do |step|
  puts "Step: #{step.name}"
  puts "  Duration: #{step.duration.seconds}s" if step.duration.seconds
  puts "  Intensity: #{step.intensity}"
  puts "  Target HR Zone: #{step.target.heart_rate_zone.number}" if step.target.heart_rate_zone
end
```

### Working with Courses

```ruby
file = Tcx.load_file('course.tcx')
course = file.courses.first

course.name     # => "Boston Marathon 2024"

# Access course points (aid stations, turns, etc.)
course.course_points.each do |point|
  puts "#{point.name} (#{point.point_type}): #{point.position.latitude_degrees}, #{point.position.longitude_degrees}"
end
```

### Parsing XML Data

Directly manipulate TCX data without files.

```ruby
xml_string = File.read('activity.tcx')
database = Tcx.load(xml_string)

# Modify data
database.activities.first.sport = :biking

# Generate XML
xml_output = database.to_xml

# Write to file
database.dump('modified_activity.tcx')
```

### Creating New TCX Files

```ruby
# Create a new empty database
file = Tcx::File.new

# Add activities, workouts, or courses
file.database.activities = [...]

# Write to disk
file.dump('new_activity.tcx')
```

### Distance Unit Conversions

Activities, laps, course laps, trackpoints, and quick workouts all support automatic distance unit conversions:

```ruby
activity = file.activities.first

# Raw distance in meters
activity.distance_meters        # => 5000.0

# Convert to other units
activity.distance_kilometers    # => 5.0
activity.distance_miles         # => 3.10686
activity.distance_feet          # => 16404.2
activity.distance_yards         # => 5468.05

# Formatted strings
activity.distance_kilometers_s  # => "5km"
activity.distance_miles_s       # => "3.11mi"
activity.distance_meters_s      # => "5000m"
activity.distance_yards_s       # => "5468yd"
activity.distance_s             # => "5km" (alias for distance_kilometers_s)

# Works on laps, trackpoints, and course laps too
lap = activity.laps.first
lap.distance_miles              # => 0.621371
lap.distance_miles_s            # => "0.62mi"
```

### Speed and Pace Conversions

Activities and laps support automatic speed and pace conversions:

```ruby
# Activity-level speed/pace (calculated from total distance and time)
activity.average_speed                       # => 3.33
activity.average_speed_kilometer_per_hour_s  # => "12.0km/h"
activity.average_speed_miles_per_hour_s      # => "7.5mph"
activity.pace_per_kilometer_s                # => "5m00s/km"
activity.pace_per_mile_s                     # => "8m03s/mi"

# Lap-level speed/pace (from extension data)
lap = activity.laps.first
lap.average_speed                       # => 3.5 (from extension data)
lap.average_speed_kilometer_per_hour_s  # => "12.6km/h"
lap.average_speed_miles_per_hour_s      # => "7.8mph"
lap.average_speed_s                     # => "12.6km/h" (alias)
lap.pace_per_kilometer_s                # => "4m46s/km"
lap.pace_per_mile_s                     # => "7m38s/mi"
lap.pace_per_100_meters_s               # => "0m28s/100m"
lap.pace_per_100_yards_s                # => "0m26s/100yd"
```

### More Examples

See [examples](examples) for a complete set of runnable examples:

- **[quick_start.rb](examples/quick_start.rb)** - Basic usage: loading files and accessing activities
- **[working_with_activities.rb](examples/working_with_activities.rb)** - Detailed activity analysis with GPS data and extensions
- **[working_with_workouts.rb](examples/working_with_workouts.rb)** - Structured workout plans with steps and targets
- **[working_with_courses.rb](examples/working_with_courses.rb)** - Course routes with waypoints and GPS tracks
- **[parsing_xml_data.rb](examples/parsing_xml_data.rb)** - In-memory XML parsing and modification
- **[creating_new_files.rb](examples/creating_new_files.rb)** - Creating new TCX files from templates
- **[multiple_running_activities.rb](examples/multiple_running_activities.rb)** - Working with multiple activities
- **[brighton_beach_course.rb](examples/brighton_beach_course.rb)** - Course analysis example
- **[dump_and_diff.rb](bin/dump_and_diff.rb)** - Round-trip XML verification utility

Run any example with:

```bash
bundle exec ruby examples/quick_start.rb
```

Run the [dump_and_diff](bin/dump_and_diff.rb) utility with:

```bash
bundle exec ruby bin/dump_and_diff.rb path/to/activity.tcx
```

## Upgrading

See [UPGRADING](UPGRADING.md).

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2025, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
