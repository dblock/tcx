# frozen_string_literal: true

module Tcx
  class MultisportSession < Base
    property 'id', from: 'Id', transform_with: ->(v) { ::Time.parse(v) }
    property 'first_sport', from: 'FirstSport', transform_with: ->(v) { FirstSport.parse(v) }
    property 'next_sports', from: 'NextSport', transform_with: ->(v) { to_array(v).map { |el| NextSport.parse(el) } }
    property 'notes', from: 'Notes'
  end
end
