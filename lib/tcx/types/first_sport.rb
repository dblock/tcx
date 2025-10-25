# frozen_string_literal: true

module Tcx
  module Types
    # FirstSport_t
    #
    # Represents the first activity in a multisport session.
    # For example, in a triathlon this would be the swim segment.
    #
    # Unlike NextSport_t, FirstSport does not have a transition element
    # since there is no transition before the first activity.
    #
    # XSD Definition:
    #   - Activity (Activity_t): The first activity/sport in the sequence
    #
    # @example Triathlon swim start
    #   first_sport = FirstSport.new('Activity' => swim_activity)
    #   first_sport.activity.sport  # => Sport::OTHER (swimming)
    #
    # @see NextSport
    # @see MultisportSession
    class FirstSport < Base
      # The first activity in the multisport sequence
      # @return [Activity] the activity object
      property 'activity', from: 'Activity', transform_with: ->(v) { Activity.parse(v) }
    end
  end
end
