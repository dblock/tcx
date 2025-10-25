# frozen_string_literal: true

module Tcx
  module Types
    # NextSport_t
    #
    # Represents a subsequent activity in a multisport session, optionally preceded
    # by a transition period. Used after FirstSport in the multisport sequence.
    #
    # For example, in a triathlon:
    #   - NextSport 1: T1 transition + bike segment
    #   - NextSport 2: T2 transition + run segment
    #
    # XSD Definition:
    #   - Transition (ActivityLap_t): Optional transition period (T1, T2, etc.)
    #   - Activity (Activity_t): The activity/sport segment
    #
    # @example Triathlon bike segment with T1
    #   next_sport = NextSport.new(
    #     'Transition' => t1_lap,  # Swim-to-bike transition
    #     'Activity' => bike_activity
    #   )
    #
    # @see FirstSport
    # @see MultisportSession
    class NextSport < Base
      # Optional transition period before this activity (e.g., T1, T2 in triathlon)
      # @return [Lap, nil] transition lap or nil if no transition
      property 'transition', from: 'Transition', transform_with: ->(v) { Lap.parse(v) }

      # The activity/sport segment following the transition
      # @return [Activity] the activity object
      property 'activity', from: 'Activity', transform_with: ->(v) { Activity.parse(v) }
    end
  end
end
