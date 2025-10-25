# frozen_string_literal: true

module Tcx
  # MultiSportFolder_t
  #
  # Represents a folder structure for organizing multisport activities (e.g., triathlons, duathlons).
  # This type is used within the History section of a TCX file to categorize and group
  # multisport training sessions.
  #
  # XSD Definition:
  #   - Folder (MultiSportFolder_t): Recursive subfolder structure (0..unbounded)
  #   - MultisportActivityRef (ActivityReference_t): References to multisport activities (0..unbounded)
  #   - Week (Week_t): Weekly groupings of activities (0..unbounded)
  #   - Notes (string): Optional descriptive notes
  #   - Extensions (Extensions_t): Optional extension data
  #   - Name (attribute, required): Folder name identifier
  #
  # @example
  #   folder = MultiSportFolder.new(
  #     'Name' => 'Triathlons',
  #     'Notes' => 'All triathlon training sessions'
  #   )
  class MultiSportFolder < Base
    # Nested subfolders for hierarchical organization
    # @return [Array<MultiSportFolder>] array of subfolder objects
    property 'folders', from: 'Folder', transform_with: ->(v) { to_array(v).map { |el| MultiSportFolder.parse(el) } }

    # References to multisport activity sessions
    # @return [Array<ActivityReference>] array of activity reference objects
    property 'multisport_activity_references', from: 'MultisportActivityRef', transform_with: ->(v) { to_array(v).map { |el| ActivityReference.parse(el) } }

    # Weekly groupings of activities
    # @return [Array<Week>] array of week objects
    property 'weeks', from: 'Week', transform_with: ->(v) { to_array(v).map { |el| Week.parse(el) } }

    # Optional descriptive notes about this folder
    # @return [String, nil] notes text or nil if not present
    property 'notes', from: 'Notes'

    # Optional extension data for custom fields
    # @return [ExtensionsList, nil] extensions object or nil if not present
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    # Folder name (stored as attribute in XML)
    # @return [String] the folder name
    property 'name', from: 'Name'

    # Define which properties should be rendered as XML attributes
    # @return [Array<String>] list of attribute property names
    def self.attributes
      %w[name]
    end
  end
end
