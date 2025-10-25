# frozen_string_literal: true

# Dump and Diff Example
#
# This example demonstrates the library's round-trip XML fidelity. It loads a TCX
# file, writes it back out, and compares the two files to verify they are identical.
#
# This is an important test to ensure the library:
# - Parses all XML elements correctly
# - Preserves all data during serialization
# - Maintains XML structure and formatting
# - Doesn't lose or corrupt any information
#
# Usage:
#   ruby examples/dump_and_diff.rb path/to/activity.tcx
#
# Expected result:
#   No output from diff command (files are identical)
#   Exit code 0 indicates success

require 'tcx'
require 'tmpdir'

# Get filename from command line arguments
# Raises an error if no filename is provided
filename = ARGV[0] || raise('Missing filename.')

# Expand to absolute path for clarity
path = File.expand_path(filename)

puts 'Dump and Diff Example'
puts '=' * 50
puts
puts 'Round-Trip XML Fidelity Test'
puts

# Load the TCX file
puts 'Step 1: Loading original file'
puts "  File: #{File.basename(path)}"
puts "  Size: #{File.size(path)} bytes"
tcx = Tcx.load_file(path)
puts '  Status: Loaded successfully'
puts

# Write to a temporary file with the same filename
# Using tmpdir ensures we don't overwrite the original file
puts 'Step 2: Writing to temporary file'
target_path = File.join(Dir.tmpdir, File.basename(filename))
tcx.dump(target_path)
puts "  Output: #{target_path}"
puts "  Size: #{File.size(target_path)} bytes"
puts '  Status: Written successfully'
puts

# Use Unix diff to compare the files
# If the library has perfect round-trip fidelity, diff will produce no output
# and exit with code 0 (success)
#
# Note: Some minor whitespace differences may occur, but the XML structure
# and all data should be identical
puts 'Step 3: Comparing files'
puts "  Running: diff \"#{File.basename(path)}\" \"#{File.basename(target_path)}\""
puts
result = system "diff \"#{path}\" \"#{target_path}\""
puts
if result
  puts 'Success! Files are identical - perfect round-trip XML fidelity.'
else
  puts 'Differences found. See diff output above.'
end
