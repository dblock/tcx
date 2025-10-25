# frozen_string_literal: true

module Tcx
  # HistoryFolder_t
  #
  # Represents a hierarchical folder structure for organizing activity history.
  # Used within Running, Biking, and Other sections of the History to categorize
  # past activities by custom folders, weekly groupings, or other organizational schemes.
  #
  # Features:
  #   - Recursive folder structure for unlimited nesting
  #   - Activity references pointing to actual Activity_t objects
  #   - Weekly groupings for calendar-based organization
  #   - Support for notes and extensions
  #
  # XSD Definition:
  #   - Folder (HistoryFolder_t): Nested subfolder structure (0..unbounded)
  #   - ActivityRef (ActivityReference_t): References to activities (0..unbounded)
  #   - Week (Week_t): Weekly activity groupings (0..unbounded)
  #   - Notes (string): Optional folder notes
  #   - Extensions (Extensions_t): Optional extension data
  #   - Name (attribute, required): Folder name identifier
  #
  # @example Creating a folder hierarchy
  #   folder = HistoryFolder.new(
  #     'Name' => 'Marathon Training',
  #     'Notes' => 'Preparing for Boston Marathon 2024',
  #     'Folder' => [
  #       { 'Name' => 'Base Building' },
  #       { 'Name' => 'Speed Work' }
  #     ]
  #   )
  class HistoryFolder < Base
    # Nested subfolders for hierarchical organization
    # Allows unlimited depth for organizing activities
    # @return [Array<HistoryFolder>] array of subfolder objects
    property 'folders', from: 'Folder', transform_with: ->(v) { to_array(v).map { |el| HistoryFolder.parse(el) } }

    # References to individual activities stored in this folder
    # Each reference points to an Activity_t by its Id (timestamp)
    # @return [Array<ActivityReference>] array of activity reference objects
    property 'activity_references', from: 'ActivityRef', transform_with: ->(v) { to_array(v).map { |el| ActivityReference.parse(el) } }

    # Weekly groupings of activities for calendar-based organization
    # Each week is identified by a start date and can contain notes
    # @return [Array<Week>] array of week objects
    property 'weeks', from: 'Week', transform_with: ->(v) { to_array(v).map { |el| Week.parse(el) } }

    # Optional descriptive notes about this folder
    # @return [String, nil] notes text or nil if not present
    property 'notes', from: 'Notes'

    # Optional extension data for custom fields
    # @return [ExtensionsList, nil] extensions object or nil if not present
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    # Define which properties should be rendered as XML attributes
    # @return [Array<String>] list of attribute property names
    def self.attributes
      %w[name]
    end

    # Folder name (stored as attribute in XML)
    # @return [String] the folder name
    property 'name', from: 'Name'
  end
end
