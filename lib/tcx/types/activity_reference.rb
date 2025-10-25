# frozen_string_literal: true

module Tcx
  module Types
    # ActivityReference_t
    #
    # A reference to an activity using its start time as the unique identifier.
    # Used in folder structures to link to activities stored in the ActivityList.
    #
    # Activities are uniquely identified by their start time (down to the second),
    # which serves as the activity ID throughout the TCX file.
    #
    # XSD Definition:
    #   - Id (Time): Activity start time (unique identifier)
    #
    # @example Reference to an activity that started at 9:00 AM
    #   ref = ActivityReference.new('Id' => '2024-03-15T09:00:00Z')
    #   ref.id # => 2024-03-15 09:00:00 UTC
    #
    # @see Activity
    # @see HistoryFolder
    # @see ActivityList
    class ActivityReference < Base
      # Activity identifier (start time)
      # @return [Time] activity start time
      property 'id', from: 'Id', transform_with: ->(v) { ::Time.parse(v) }
    end
  end
end
