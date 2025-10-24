# TCX

[![Gem Version](https://badge.fury.io/rb/tcx.svg)](https://badge.fury.io/rb/tcx)
[![Test](https://github.com/dblock/tcx/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/dblock/tcx/actions/workflows/test.yml)

A Garmin Training Center XML (TCX) reader and writer. Unlike other libraries such as [tcx_rb](https://github.com/keithdoggett/tcx_rb) or [tcxread](https://github.com/firefly-cpp/tcxread), provides a consistent API by implementing the complete read/write [TCX schema](https://www8.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd) with extensions in a structured and organized way.

## Installation

Add to Gemfile.

```
gem 'tcx'
```

Run `bundle install`.

## Usage

### Working with Files

Read and write TCX files using `Tcx#load_file` and `dump`. 

```ruby
require 'tcx'

tcx = Tcx.load_file('activities.tcx') # => Tcx::Database

tcx.activities # => [Tcx::Activity], array of Tcx::Activity
tcx.workouts # => [Tcx::Workout]
tcx.courses # => [Tcx::Course]

tcx.dump # overwrites activities.tcx

tcx.dump('activities2.tcx') # writes to activities2.tcx
```

### Working with XML Data

Directly manipulate TCX data without creating files.

```ruby
data = File.read('activities.tcx') # String

tcx = Tcx.load(data) # => Tcx::Database

tcx.to_xml # => XML string

tcx.dump('activities2.tcx') # writes to activities2.tcx
```

### Examples

See [examples/multiple_running_activities.rb](examples/multiple_running_activities.rb) for a complete working example.

## Upgrading

See [UPGRADING](UPGRADING.md).

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2025, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
