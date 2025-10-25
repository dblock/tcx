# frozen_string_literal: true

module Tcx
  class History < Base
    property 'running', from: 'Running', transform_with: ->(v) { HistoryFolder.parse(v) }
    property 'biking', from: 'Biking', transform_with: ->(v) { HistoryFolder.parse(v) }
    property 'other', from: 'Other', transform_with: ->(v) { HistoryFolder.parse(v) }
    property 'multi_sport', from: 'MultiSport', transform_with: ->(v) { MultiSportFolder.parse(v) }
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }
  end
end
