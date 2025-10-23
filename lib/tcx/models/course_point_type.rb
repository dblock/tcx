# frozen_string_literal: true

module Tcx
  class CoursePointType
    include Ruby::Enum

    define :generic, 'Generic'
    define :summit, 'Summit'
    define :valley, 'Valley'
    define :water, 'Water'
    define :food, 'Food'
    define :danger, 'Danger'
    define :left, 'Left'
    define :right, 'Right'
    define :straight, 'Straight'
    define :first, 'First'
    define :category_4th, '4th Category'
    define :category_3rd, '3rd Category'
    define :category_2nd, '2nd Category'
    define :category_1st, '1st Category'
    define :hors, 'Hors'
    define :sprint, 'Sprint'
  end
end
