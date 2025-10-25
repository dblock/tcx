# frozen_string_literal: true

require 'tcx'
require 'tmpdir'

# read/write and diff

filename = ARGV[0] || raise('Missing filename.')

path = File.expand_path(filename)
puts "Loading #{path}, #{File.size(path)} byte(s)"
tcx = Tcx.load_file(path)
target_path = File.join(Dir.tmpdir, File.basename(filename))
tcx.dump(target_path)
puts "Wrote #{target_path}, #{File.size(target_path)} byte(s)"

system "diff \"#{path}\" \"#{target_path}\""
