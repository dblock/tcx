# frozen_string_literal: true

require 'hashie'
require 'time'
require 'ruby-enum'
require 'nokogiri'

require_relative 'tcx/version'
require_relative 'tcx/models'

module Tcx
  def self.load_file(path)
    xml = Nokogiri::XML(File.open(path))
    xml.root.add_namespace_definition('ns3', 'http://www.garmin.com/xmlschemas/ActivityExtension/v2')
    Tcx::Database.parse(xml.root)
  end
end
