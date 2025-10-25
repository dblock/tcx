# frozen_string_literal: true

module Tcx
  class WorkoutFolder < Base
    property 'name', from: 'Name'
    property 'folders', from: 'Folder', transform_with: ->(v) { to_array(v).map { |el| WorkoutFolder.parse(el) } }
    property 'workout_name_ref', from: 'WorkoutNameRef', transform_with: ->(v) { to_array(v).map { |el| NameKeyReference.parse(el) } }
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    def self.attributes
      ['name']
    end
  end
end
