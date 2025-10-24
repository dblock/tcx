# frozen_string_literal: true

module Tcx
  class Folders < Base
    property 'history', from: 'History', transform_with: ->(v) { to_array(v).map { |el| History.parse(el) } }
    property 'courses', from: 'Courses', transform_with: ->(v) { to_array(v).map { |el| Courses.parse(el) } }
    property 'workouts', from: 'Workouts', transform_with: ->(v) { to_array(v).map { |el| Workouts.parse(el) } }
  end
end
