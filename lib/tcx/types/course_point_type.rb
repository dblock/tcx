# frozen_string_literal: true

module Tcx
  # CoursePointType_t (simple type, enumeration)
  #
  # Specifies the type of course waypoint. Used to categorize points of interest along
  # a route for navigation, safety, and race information.
  #
  # Categories:
  #   - Generic: General waypoint (default)
  #   - Terrain: Summit, Valley
  #   - Services: Water, Food
  #   - Navigation: Left, Right, Straight
  #   - Safety: Danger
  #   - Racing: First (finish line), Sprint (sprint point)
  #   - Cycling Climbs: 4th Category, 3rd Category, 2nd Category, 1st Category, Hors Catégorie
  #
  # The climb categories follow professional cycling's classification system:
  #   - 4th Category: Easiest climbs
  #   - 3rd Category: Moderate climbs
  #   - 2nd Category: Difficult climbs
  #   - 1st Category: Very difficult climbs
  #   - Hors Catégorie: Beyond categorization (hardest climbs)
  #
  # @example Water station
  #   type = CoursePointType.parse('Water')
  #
  # @example Hors Catégorie climb (e.g., Alpe d'Huez)
  #   type = CoursePointType.parse('Hors')
  #
  # @see CoursePoint
  class CoursePointType
    include Ruby::Enum

    # Generic waypoint (default)
    define :generic, 'Generic'

    # Mountain summit or hilltop
    define :summit, 'Summit'

    # Valley or low point
    define :valley, 'Valley'

    # Water station or aid stop
    define :water, 'Water'

    # Food station or nutrition stop
    define :food, 'Food'

    # Hazard or danger warning
    define :danger, 'Danger'

    # Turn left instruction
    define :left, 'Left'

    # Turn right instruction
    define :right, 'Right'

    # Continue straight instruction
    define :straight, 'Straight'

    # Finish line
    define :first, 'First'

    # Category 4 climb (easiest)
    define :category_4th, '4th Category'

    # Category 3 climb (moderate)
    define :category_3rd, '3rd Category'

    # Category 2 climb (difficult)
    define :category_2nd, '2nd Category'

    # Category 1 climb (very difficult)
    define :category_1st, '1st Category'

    # Hors Catégorie climb (beyond categorization, hardest)
    define :hors, 'Hors'

    # Sprint point (intermediate sprint in races)
    define :sprint, 'Sprint'
  end
end
