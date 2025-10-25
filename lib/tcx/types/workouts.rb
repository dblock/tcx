# frozen_string_literal: true

module Tcx
  module Types
    # Workouts_t
    #
    # Top-level container for organizing structured workouts by sport type.
    # Workouts are organized into three main categories: Running, Biking, and Other.
    # Each category contains a folder structure for further organization.
    #
    # This structure mirrors the Folders > History organization, but for planned workouts
    # rather than completed activities.
    #
    # XSD Definition:
    #   - Running (WorkoutFolder_t): Running workouts folder
    #   - Biking (WorkoutFolder_t): Cycling workouts folder
    #   - Other (WorkoutFolder_t): All other sport workouts folder
    #   - Extensions (Extensions_t): Additional vendor-specific data
    #
    # @example Accessing running workouts
    #   database = Database.load(xml_data)
    #   running_folder = database.folders.workouts.running
    #
    # @see WorkoutFolder
    # @see Workout
    # @see Folders
    class Workouts < Base
      # Running workouts folder and subfolders
      # @return [WorkoutFolder, nil] running folder or nil
      property 'running', from: 'Running', transform_with: ->(v) { WorkoutFolder.parse(v) }

      # Cycling workouts folder and subfolders
      # @return [WorkoutFolder, nil] biking folder or nil
      property 'biking', from: 'Biking', transform_with: ->(v) { WorkoutFolder.parse(v) }

      # Other sports workouts folder and subfolders
      # @return [WorkoutFolder, nil] other folder or nil
      property 'other', from: 'Other', transform_with: ->(v) { WorkoutFolder.parse(v) }

      # Vendor-specific extensions
      # @return [ExtensionsList, nil] extensions or nil
      property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
    end
  end
end
