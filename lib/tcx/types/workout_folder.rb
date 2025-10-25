# frozen_string_literal: true

module Tcx
  module Types
    # WorkoutFolder_t
    #
    # Represents a folder for organizing structured workouts within a sport category.
    # Folders can be nested to create hierarchical organization (e.g., "Speed Work" > "Track Intervals").
    #
    # Each folder can contain:
    #   - Subfolders: Nested folders for further organization
    #   - WorkoutNameRef: References to actual Workout objects by name
    #
    # This allows users to organize their workout library just like organizing files
    # in a filesystem.
    #
    # XSD Definition:
    #   - Name (Token): Folder name (stored as XML attribute)
    #   - Folder (WorkoutFolder_t): Nested subfolders
    #   - WorkoutNameRef (NameKeyReference_t): References to workouts in this folder
    #   - Extensions (Extensions_t): Additional vendor-specific data
    #
    # @example Folder containing interval workouts
    #   folder = WorkoutFolder.new(
    #     'Name' => 'Speed Work',
    #     'Folder' => [
    #       { 'Name' => 'Track', 'WorkoutNameRef' => [{ 'Id' => 'Yasso 800s' }] },
    #       { 'Name' => 'Tempo', 'WorkoutNameRef' => [{ 'Id' => 'Lactate Threshold' }] }
    #     ]
    #   )
    #
    # @see Workouts
    # @see Workout
    # @see NameKeyReference
    class WorkoutFolder < Base
      # Folder name (stored as XML attribute)
      # @return [String] folder name
      property 'name', from: 'Name'

      # Nested subfolders for hierarchical organization
      # @return [Array<WorkoutFolder>, nil] array of subfolders or nil
      property 'folders', from: 'Folder', transform_with: ->(v) { to_array(v).map { |el| WorkoutFolder.parse(el) } }

      # References to workouts contained in this folder
      # @return [Array<NameKeyReference>, nil] array of workout references or nil
      property 'workout_name_ref', from: 'WorkoutNameRef', transform_with: ->(v) { to_array(v).map { |el| NameKeyReference.parse(el) } }

      # Vendor-specific extensions
      # @return [ExtensionsList, nil] extensions or nil
      property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

      # XML attributes for this type
      # @return [Array<String>] attribute names
      def self.attributes
        ['name']
      end
    end
  end
end
