# frozen_string_literal: true

module Tcx
  # Courses_t
  #
  # Top-level container for organizing course routes. Contains the root CourseFolder
  # that holds all courses and their folder hierarchy.
  #
  # This structure is simpler than Workouts_t (which has separate Running/Biking/Other
  # folders) - courses use a single unified folder structure regardless of sport type.
  #
  # XSD Definition:
  #   - CourseFolder (CourseFolder_t): Root folder containing all courses
  #
  # @example Accessing courses
  #   database = Database.load(xml_data)
  #   root_folder = database.folders.courses.course_folder
  #   root_folder.course_references.each do |ref|
  #     puts ref.id
  #   end
  #
  # @see CourseFolder
  # @see Course
  # @see Folders
  class Courses < Base
    # Root folder containing all courses and subfolders
    # @return [CourseFolder, nil] root course folder or nil
    property 'course_folder', from: 'CourseFolder', transform_with: ->(v) { CourseFolder.parse(v) }
  end
end
