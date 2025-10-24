# frozen_string_literal: true

require 'hashie'
require 'time'
require 'ruby-enum'
require 'nokogiri'
require 'forwardable'

require_relative 'tcx/version'
require_relative 'tcx/types'
require_relative 'tcx/extensions'
require_relative 'tcx/file'

module Tcx
  def self.load_file(path)
    Tcx::File.new(path)
  end

  def self.load(data)
    Tcx::Database.load(data)
  end
end
