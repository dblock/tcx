# frozen_string_literal: true

module Tcx
  # HistoryFolder_t
  # Organizes history by activity folders
  class HistoryFolder < Base
    property 'folders', from: 'Folder', transform_with: ->(v) { to_array(v).map { |el| HistoryFolder.parse(el) } }
    property 'activity_references', from: 'ActivityRef', transform_with: ->(v) { to_array(v).map { |el| ActivityReference.parse(el) } }
    property 'weeks', from: 'Week', transform_with: ->(v) { to_array(v).map { |el| Week.parse(el) } }
    property 'notes', from: 'Notes'
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    def self.attributes
      %w[name]
    end

    property 'name', from: 'Name'
  end
end
