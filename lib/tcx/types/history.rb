# frozen_string_literal: true

module Tcx
  # History_t
  #
  # Top-level container for organizing completed activities by sport type.
  # Activities are organized into four main categories: Running, Biking, Other, and MultiSport.
  # Each category contains a folder structure for further organization.
  #
  # This provides the organizational structure for the activity history stored in a TCX file,
  # allowing users to categorize and group their completed workouts.
  #
  # XSD Definition:
  #   - Running (HistoryFolder_t): Running activities folder
  #   - Biking (HistoryFolder_t): Cycling activities folder
  #   - Other (HistoryFolder_t): All other sport activities folder
  #   - MultiSport (MultiSportFolder_t): Multisport activities (triathlons, etc.)
  #   - Extensions (Extensions_t): Additional vendor-specific data
  #
  # @example Accessing running activities
  #   database = Database.load(xml_data)
  #   running_folder = database.folders.history.running
  #   running_folder.activity_refs.each do |ref|
  #     puts ref.id
  #   end
  #
  # @see HistoryFolder
  # @see MultiSportFolder
  # @see ActivityList
  # @see Folders
  class History < Base
    # Running activities folder and subfolders
    # @return [HistoryFolder, nil] running folder or nil
    property 'running', from: 'Running', transform_with: ->(v) { HistoryFolder.parse(v) }

    # Cycling activities folder and subfolders
    # @return [HistoryFolder, nil] biking folder or nil
    property 'biking', from: 'Biking', transform_with: ->(v) { HistoryFolder.parse(v) }

    # Other sports activities folder and subfolders
    # @return [HistoryFolder, nil] other folder or nil
    property 'other', from: 'Other', transform_with: ->(v) { HistoryFolder.parse(v) }

    # Multisport activities folder (triathlons, duathlons, etc.)
    # @return [MultiSportFolder, nil] multisport folder or nil
    property 'multi_sport', from: 'MultiSport', transform_with: ->(v) { MultiSportFolder.parse(v) }

    # Vendor-specific extensions
    # @return [ExtensionsList, nil] extensions or nil
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
  end
end
