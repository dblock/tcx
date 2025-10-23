# frozen_string_literal: true

module Tcx
  class File
    extend Forwardable

    attr_accessor :file_path

    def_delegators :database, :folders, :activities, :workouts, :courses, :author, :to_xml

    def initialize(file_path = nil)
      @file_path = file_path
    end

    def database
      @database ||= if file_path
                      ::File.open(file_path) do |file|
                        xml = Nokogiri::XML(file)
                        Tcx::Database.parse(xml.root)
                      end
                    else
                      Tcx::Database.new
                    end
    end

    def dump(target_path = nil)
      database.dump(target_path)
    end
  end
end
