# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'tcx/version'

Gem::Specification.new do |s|
  s.name = 'tcx'
  s.bindir = 'bin'
  s.version = Tcx::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 3.0'
  s.required_rubygems_version = '>= 2.5'
  s.files = Dir['{bin,lib}/**/*'] + ['README.md', 'LICENSE.md', 'CHANGELOG.md']
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/tcx'
  s.licenses = ['MIT']
  s.summary = 'A Garmin Training Center XML (TCX) reader/writer.'
  s.add_dependency 'hashie'
  s.add_dependency 'nokogiri'
  s.add_dependency 'ruby-enum'
  s.metadata['rubygems_mfa_required'] = 'true'
end
