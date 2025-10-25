# frozen_string_literal: true

module Tcx
  module Types
    # Week_t
    #
    # Represents a weekly grouping container within HistoryFolder or MultiSportFolder.
    # Used to organize activities by calendar weeks, with each week identified by its
    # start date and optionally containing notes.
    #
    # Note: According to the XSD documentation, "The week is written out only if the notes are present."
    # However, the StartDay attribute is always required when a Week element exists.
    #
    # XSD Definition:
    #   - Notes (string): Optional notes about this week's activities
    #   - StartDay (attribute, date, required): The start date of the week
    #
    # @example Creating a week grouping
    #   week = Week.new(
    #     'StartDay' => '2024-06-10',
    #     'Notes' => 'Recovery week - easy mileage'
    #   )
    class Week < Base
      # Optional notes about this week's training or activities
      # Per XSD spec, the Week element is typically only present when notes exist
      # @return [String, nil] notes text or nil if not present
      property 'notes', from: 'Notes'

      # The start date of this week (stored as XML attribute)
      # Identifies which calendar week this grouping represents
      # @return [Date] the week start date
      property 'start_day', from: 'StartDay', transform_with: ->(v) { Date.parse(v) }

      # Define which properties should be rendered as XML attributes
      # @return [Array<String>] list of attribute property names
      def self.attributes
        %w[start_day]
      end
    end
  end
end
