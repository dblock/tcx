# frozen_string_literal: true

module Tcx
  class Folders < Base
    property 'folders', from: 'Folder', transform_with: ->(v) { to_array(v).map { |el| CourseFolder.parse(el) } }
  end
end
