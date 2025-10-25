# frozen_string_literal: true

module Tcx
  # CadenceTarget_t (extends Target_t)
  #
  # Defines a target cadence range for a workout step. Used to maintain efficient
  # form and pacing during structured workouts.
  #
  # Common use cases:
  #   - Running form drills: "Maintain 180 steps/min"
  #   - Cycling efficiency: "Keep cadence between 85-95 RPM"
  #   - High-cadence intervals: "Spin at 100-110 RPM"
  #
  # XSD Definition:
  #   - Low (double): Lower cadence boundary
  #   - High (double): Upper cadence boundary
  #
  # @example Target cadence for running form drill
  #   target = CadenceTarget.new('Low' => 175.0, 'High' => 185.0)
  #
  # @example Cycling cadence target
  #   target = CadenceTarget.new('Low' => 85.0, 'High' => 95.0)
  #
  # @see Target
  # @see Cadence
  # @see Step
  class CadenceTarget < Target
    # Lower cadence boundary (steps/min or RPM)
    # @return [Float] low cadence value
    property 'low', from: 'Low', transform_with: lambda(&:to_f)

    # Upper cadence boundary (steps/min or RPM)
    # @return [Float] high cadence value
    property 'high', from: 'High', transform_with: lambda(&:to_f)
  end
end
