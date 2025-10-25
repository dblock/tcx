# frozen_string_literal: true

module Tcx
  module Types
    # None_t (extends Duration_t)
    #
    # Represents an open-ended duration for workout steps. Specifies that a step should
    # continue until manually stopped by the user.
    #
    # This duration type is used for flexible workout steps where the exact duration
    # isn't predetermined, such as:
    #   - "Cool down until ready"
    #   - "Run easy to finish"
    #   - Open-ended warm-up or recovery periods
    #
    # XSD Definition:
    #   - (no properties - empty type)
    #
    # @example Open-ended cool down
    #   duration = None.new
    #
    # @see Duration
    # @see Step
    class None < Base
      # XML attributes including xsi:type for polymorphism
      # @return [Hash] attribute hash with xsi:type
      def attributes
        super.merge('xsi:type' => 'None_t')
      end
    end
  end
end
