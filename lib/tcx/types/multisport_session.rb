# frozen_string_literal: true

module Tcx
  module Types
    # MultiSportSession_t
    #
    # Represents a complete multisport activity session such as a triathlon, duathlon, or aquathlon.
    # A multisport session consists of multiple sequential activities (sports) with optional
    # transitions between them.
    #
    # Structure:
    #   - FirstSport: The initial activity (e.g., swim in a triathlon)
    #   - NextSport(s): Subsequent activities with optional transitions (e.g., T1 -> bike -> T2 -> run)
    #
    # XSD Definition:
    #   - Id (dateTime): Unique identifier timestamp for the session
    #   - FirstSport (FirstSport_t): The first activity in the sequence
    #   - NextSport (NextSport_t): Additional activities with transitions (0..unbounded)
    #   - Notes (string): Optional notes about the session
    #
    # @example Triathlon structure
    #   session = MultisportSession.new(
    #     'Id' => '2024-06-15T08:00:00Z',
    #     'FirstSport' => { 'Activity' => swim_activity },
    #     'NextSport' => [
    #       { 'Transition' => t1_lap, 'Activity' => bike_activity },
    #       { 'Transition' => t2_lap, 'Activity' => run_activity }
    #     ]
    #   )
    class MultisportSession < Base
      # Unique identifier timestamp for the session (typically the start time)
      # @return [Time] the session identifier as a Time object
      property 'id', from: 'Id', transform_with: ->(v) { ::Time.parse(v) }

      # The first activity in the multisport sequence
      # This could be the swim in a triathlon, run in a duathlon, etc.
      # @return [FirstSport] the initial sport activity
      property 'first_sport', from: 'FirstSport', transform_with: ->(v) { FirstTypes::Sport.parse(v) }

      # Subsequent activities in the sequence, each with an optional transition
      # For a triathlon: [bike with T1 transition, run with T2 transition]
      # @return [Array<NextSport>] array of subsequent sport activities
      property 'next_sports', from: 'NextSport', transform_with: ->(v) { to_array(v).map { |el| NextTypes::Sport.parse(el) } }

      # Optional notes about the multisport session
      # @return [String, nil] notes text or nil if not present
      property 'notes', from: 'Notes'
    end
  end
end
