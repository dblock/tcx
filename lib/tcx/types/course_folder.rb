# frozen_string_literal: true

module Tcx
  module Types
    # CourseFolder_t
    #
    # Represents a folder for organizing course routes. Folders can be nested to create
    # hierarchical organization (e.g., "Race Courses" > "Marathons" > "Boston Marathon").
    #
    # Each folder can contain:
    #   - Subfolders: Nested folders for further organization
    #   - CourseNameRef: References to actual Course objects by name
    #   - Notes: Optional folder description
    #
    # This structure mirrors WorkoutFolder and HistoryFolder, providing consistent
    # organization across different TCX data types.
    #
    # XSD Definition:
    #   - Folder (CourseFolder_t): Nested subfolders
    #   - CourseNameRef (NameKeyReference_t): References to courses in this folder
    #   - Notes (Token): Optional folder description
    #   - Name (Token): Folder name (stored as XML attribute)
    #
    # @example Organizing race courses
    #   folder = CourseFolder.new(
    #     'Name' => 'Race Courses',
    #     'Folder' => [
    #       { 'Name' => 'Marathons', 'CourseNameRef' => [{ 'Id' => 'Boston Marathon' }] },
    #       { 'Name' => '5Ks', 'CourseNameRef' => [{ 'Id' => 'Parkrun' }] }
    #     ],
    #     'Notes' => 'Courses for upcoming races'
    #   )
    #
    # @see Courses
    # @see Course
    # @see NameKeyReference
    class CourseFolder < Base
      # Nested subfolders for hierarchical organization
      # @return [Array<CourseFolder>, nil] array of subfolders or nil
      property 'folders', from: 'Folder', transform_with: ->(v) { to_array(v).map { |el| CourseFolder.parse(el) } }

      # References to courses contained in this folder
      # @return [Array<NameKeyReference>, nil] array of course references or nil
      property 'course_references', from: 'CourseNameRef', transform_with: ->(v) { to_array(v).map { |el| NameKeyReference.parse(el) } }

      # Optional folder description
      # @return [String, nil] notes text or nil
      property 'notes', from: 'Notes'

      # Folder name (stored as XML attribute)
      # @return [String] folder name
      property 'name', from: 'Name'

      # XML attributes for this type
      # @return [Array<String>] attribute names
      def self.attributes
        ['name']
      end
    end
  end
end
