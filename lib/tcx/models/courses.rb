# frozen_string_literal: true

module Tcx
  class Courses < Base
    property 'course_folder', from: 'CourseFolder', transform_with: ->(v) { CourseFolder.parse(v) }
  end
end
