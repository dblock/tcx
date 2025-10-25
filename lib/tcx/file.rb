# frozen_string_literal: true

module Tcx
  # File
  #
  # High-level API for working with TCX files. Provides convenient access to TCX data
  # and delegates common operations to the underlying Database object.
  #
  # This class handles:
  #   - Loading TCX files from disk
  #   - Parsing XML into Ruby objects
  #   - Delegating property access to Database
  #   - Dumping database back to XML files
  #
  # @example Load an existing TCX file
  #   file = Tcx::File.new('/path/to/activity.tcx')
  #   file.activities.each do |activity|
  #     puts "#{activity.sport}: #{activity.distance_meters}m"
  #   end
  #
  # @example Create a new TCX file
  #   file = Tcx::File.new
  #   file.database.activities = [...]
  #   file.dump('/path/to/output.tcx')
  #
  # @see Types::Database
  # @see Tcx.load_file
  class File
    extend Forwardable

    # Path to the TCX file on disk
    # @return [String, nil] file path or nil for in-memory database
    attr_accessor :file_path

    # Delegate common accessors to the database
    def_delegators :database, :folders, :activities, :workouts, :courses, :author, :to_xml

    # Initialize a new File instance
    # @param file_path [String, nil] path to TCX file or nil for empty database
    def initialize(file_path = nil)
      @file_path = file_path
    end

    # Get the underlying Database object, loading from file if necessary
    # @return [Types::Database] the parsed or empty database
    def database
      @database ||= if file_path
                      ::File.open(file_path) do |file|
                        xml = Nokogiri::XML(file)
                        Tcx::Types::Database.parse(xml.root)
                      end
                    else
                      Tcx::Types::Database.new
                    end
    end

    # Dump the database to an XML file
    # @param target_path [String, nil] path to write file, or nil to use original file_path
    # @return [void]
    # @see Types::Database#dump
    def dump(target_path = nil)
      database.dump(target_path)
    end
  end
end
