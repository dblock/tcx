# frozen_string_literal: true

module Tcx
  # TrainingCenterDatabase_t
  #
  # Represents the root element of a TCX (Training Center XML) file.
  # This is the top-level container for all training data including activities,
  # workouts, courses, and organizational folders.
  #
  # A TCX database is the primary data structure used by Garmin Training Center
  # and other fitness applications to store and exchange workout data.
  #
  # XSD Definition:
  #   - Folders (Folders_t): Optional organizational folder structure
  #   - Activities (ActivityList_t): Optional list of completed activities
  #   - Workouts (WorkoutList_t): Optional list of planned workouts
  #   - Courses (CourseList_t): Optional list of GPS courses/routes
  #   - Author (AbstractSource_t): Optional authoring application/device info
  #   - Extensions (Extensions_t): Optional extension data
  #
  # @example Loading a TCX file
  #   data = File.read('activity.tcx')
  #   database = Tcx::Database.load(data)
  #   puts "Found #{database.activities.count} activities"
  #
  # @example Creating and saving
  #   database = Tcx::Database.new
  #   database.dump('output.tcx')
  class Database < Base
    # Organizational folder structure for categorizing activities, workouts, and courses
    # @return [Folders, nil] the folders structure or nil if not present
    property 'folders', from: 'Folders', transform_with: ->(arr) { Folders.parse(arr) }

    # List of completed activities (runs, rides, swims, etc.)
    # @return [ActivityList, nil] the activity list or nil if not present
    property 'activities', from: 'Activities', transform_with: ->(arr) { ActivityList.parse(arr) }

    # List of planned workout definitions
    # @return [WorkoutList, nil] the workout list or nil if not present
    property 'workouts', from: 'Workouts', transform_with: ->(arr) { WorkoutList.parse(arr) }

    # List of GPS courses/routes
    # @return [CourseList, nil] the course list or nil if not present
    property 'courses', from: 'Courses', transform_with: ->(arr) { CourseList.parse(arr) }

    # Information about the application or device that created this file
    # Can be either Application_t or Device_t (polymorphic via xsi:type)
    # @return [AbstractSource, nil] the author information or nil if not present
    property 'author', from: 'Author', transform_with: ->(el) { AbstractSource.parse(el) }

    # XML namespace definitions for the document
    # @return [Hash] namespace prefix to URI mappings
    attr_accessor :namespace_definitions

    class << self
      # Load and parse a TCX database from XML string
      # @param data [String] the XML content to parse
      # @return [Database] the parsed database object
      def load(data)
        xml = Nokogiri::XML(data)
        parse(xml.root)
      end

      # Parse a TCX database from a Nokogiri XML element
      # Preserves namespace definitions from the original document
      # @param xml [Nokogiri::XML::Element] the root XML element
      # @return [Database] the parsed database object
      def parse(xml)
        instance = super
        instance.namespace_definitions = {
          'xsi:schemaLocation' => xml['xsi:schemaLocation']
        }.merge(xml.namespace_definitions.to_h do |ns|
          [['xmlns', ns.prefix].compact.join(':'), ns.href]
        end)
        instance
      end
    end

    # Write the database to a TCX file
    # @param target_path [String] the file path to write to
    # @return [Integer] the number of bytes written
    def dump(target_path)
      ::File.write(target_path, to_xml)
    end

    # Convert the database to an XML string
    # @return [String] the complete TCX XML document
    def to_xml
      to_xml_builder.to_xml
    end

    private

    # Build the XML structure using Nokogiri::XML::Builder
    # @return [Nokogiri::XML::Builder] the XML builder object
    def to_xml_builder
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.TrainingCenterDatabase(namespace_definitions) do |xml|
          build_xml(xml)
        end
      end
    end
  end
end
