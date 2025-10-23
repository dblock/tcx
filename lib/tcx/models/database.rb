# frozen_string_literal: true

module Tcx
  class Database < Base
    property 'folders', from: 'Folders', transform_with: ->(arr) { Folders.parse(arr) }
    property 'activities', from: 'Activities', transform_with: ->(arr) { ActivityList.parse(arr) }
    property 'workouts', from: 'Workouts', transform_with: ->(arr) { WorkoutList.parse(arr) }
    property 'courses', from: 'Courses', transform_with: ->(arr) { CourseList.parse(arr) }
    property 'author', from: 'Author', transform_with: ->(el) { AbstractSource.parse(el) }
  end
end
