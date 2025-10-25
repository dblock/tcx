# frozen_string_literal: true

module Tcx
  class MultiSportFolder < Base
    property 'folders', from: 'Folder', transform_with: ->(v) { to_array(v).map { |el| MultiSportFolder.parse(el) } }
    property 'multisport_activity_references', from: 'MultisportActivityRef', transform_with: ->(v) { to_array(v).map { |el| ActivityReference.parse(el) } }
    property 'weeks', from: 'Week', transform_with: ->(v) { to_array(v).map { |el| Week.parse(el) } }
    property 'notes', from: 'Notes'
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
    property 'name', from: 'Name'

    def self.attributes
      %w[name]
    end
  end
end
