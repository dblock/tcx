# frozen_string_literal: true

module Tcx
  module Types
    # HeartRateBpm (simplified wrapper)
    #
    # Simplified heart rate representation, functionally equivalent to
    # HeartRateInBeatsPerMinute_t. Used in some contexts for brevity.
    #
    # XSD Definition:
    #   - Value (unsignedByte): Heart rate value in BPM
    #
    # @example
    #   hr = HeartRateBpm.new('Value' => 150)
    #   hr.value  # => 150
    #
    # @see HeartRateInBeatsPerMinute
    class HeartRateBpm < Base
      # Heart rate value in beats per minute
      # @return [Integer] BPM value
      property 'value', from: 'Value', transform_with: lambda(&:to_i)

      # Delegate numeric operations to the value
      def_delegators :value, :to_i, :==
    end
  end
end
