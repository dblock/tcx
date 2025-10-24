# frozen_string_literal: true

module Tcx
  class Application < AbstractSource
    property 'build', from: 'Build', transform_with: ->(v) { Build.parse(v) }
    property 'lang_id', from: 'LangID'
    property 'part_number', from: 'PartNumber'

    def attributes
      super.merge('xsi:type' => 'Application_t')
    end
  end
end
