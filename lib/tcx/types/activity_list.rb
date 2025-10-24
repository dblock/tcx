# frozen_string_literal: true

module Tcx
  class ActivityList < Base
    property 'activities', from: 'Activities', transform_with: ->(v) { v.map { |el| Activity.parse(el) } }

    def_delegators :activities, :each, :count

    def self.parse(list)
      ActivityList.new('Activities' => list.xpath('xmlns:Activity'))
    end

    def build_xml(builder, namespace = nil)
      activities.each do |activity|
        builder.Activity(activity.attributes) do |activity_builder|
          activity.build_xml(activity_builder, namespace)
        end
      end
    end
  end
end
