# frozen_string_literal: true

module Tcx
  module Types
    # CaloriesBurned_t (extends Duration_t)
    #
    # Represents a calorie-based duration for workout steps. Specifies that a step should
    # continue until a target number of calories has been burned.
    #
    # This duration type is useful for:
    #   - Weight loss workouts focused on calorie burn
    #   - Matching nutrition intake to exercise output
    #   - Consistent energy expenditure across workouts
    #
    # Note: Calorie calculations depend on device algorithms and may vary based on
    # user profile settings (weight, age, gender, max HR).
    #
    # XSD Definition:
    #   - Calories (unsignedShort): Target calories to burn
    #
    # @example Burn 200 calories during warm up
    #   duration = CaloriesBurned.new('Calories' => 200)
    #
    # @example 500-calorie workout step
    #   duration = CaloriesBurned.new('Calories' => 500)
    #
    # @see Duration
    # @see Step
    class CaloriesBurned < Duration
      # Target number of calories to burn
      # @return [Integer] calories to burn
      property 'calories', from: 'Calories', transform_with: lambda(&:to_i)
    end
  end
end
