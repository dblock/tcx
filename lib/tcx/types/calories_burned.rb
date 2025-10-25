# frozen_string_literal: true

module Tcx
  class CaloriesBurned < Duration
    property 'calories', from: 'Calories', transform_with: lambda(&:to_i)
  end
end
