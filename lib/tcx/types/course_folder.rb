# frozen_string_literal: true

module Tcx
  class CourseFolder < Base
    property 'folders', from: 'Folder', transform_with: ->(v) { to_array(v).map { |el| CourseFolder.parse(el) } }
    property 'course_references', from: 'CourseNameRef', transform_with: ->(v) { to_array(v).map { |el| NameKeyReference.parse(el) } }
    property 'notes', from: 'Notes'
  end
end
