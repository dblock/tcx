# frozen_string_literal: true

module Tcx
  class Workout < Base
    property 'name', from: 'Name'
    property 'sport', from: 'Sport', transform_with: ->(v) { Sport.parse(v) }
    property 'steps', from: 'Step', transform_with: ->(v) { to_array(v).map { |el| Step.parse(el) } }
    property 'creator', from: 'Creator', transform_with: ->(v) { AbstractSource.parse(v) }
    property 'notes', from: 'Notes'
    property 'extensions', from: 'Extensions', transform_with: ->(v) { ExtensionsList.parse(v) }

    def self.attributes
      ['sport']
    end
  end
end
