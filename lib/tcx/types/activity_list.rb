# frozen_string_literal: true

module Tcx
  module Types
    # ActivityList_t
    #
    # Container for all completed activities and multisport sessions in a TCX database.
    # This is the primary collection of workout/training data.
    #
    # Activities and multisport sessions can be mixed in the same list, representing
    # the complete training history in chronological or any other order.
    #
    # XSD Definition:
    #   - Activity (Activity_t): Individual sport activities (0..unbounded)
    #   - MultiSportSession (MultiSportSession_t): Multisport activities (0..unbounded)
    #
    # @example
    #   activity_list.count  # => 42
    #   activity_list.activities.first.sport  # => Sport::RUNNING
    class ActivityList < Base
      # Collection of single-sport activities
      # @return [Array<Activity>] array of activity objects
      property 'activities', from: 'Activities', transform_with: ->(v) { v.map { |el| Activity.parse(el) } }

      # Collection of multisport sessions (triathlons, duathlons, etc.)
      # @return [Array<MultisportSession>] array of multisport session objects
      property 'multisport_sessions', from: 'MultisportSession', transform_with: ->(v) { v.map { |el| MultisportSession.parse(el) } }

      # Delegate enumeration methods to the activities collection
      def_delegators :activities, :each, :count

      # Parse an activity list from XML element
      # @param list [Nokogiri::XML::Element] the Activities XML element
      # @return [ActivityList] parsed activity list
      def self.parse(list)
        ActivityList.new(
          'Activities' => list.xpath('xmlns:Activity'),
          'MultisportSession' => list.xpath('xmlns:MultiSportSession')
        )
      end

      # Build XML representation of the activity list
      # @param builder [Nokogiri::XML::Builder] the XML builder
      # @param namespace [String, nil] optional namespace prefix
      # @return [void]
      def build_xml(builder, namespace = nil)
        activities.each do |activity|
          builder.Activity(activity.attributes) do |activity_builder|
            activity.build_xml(activity_builder, namespace)
          end
        end
      end
    end
  end
end
