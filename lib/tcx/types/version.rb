# frozen_string_literal: true

module Tcx
  class Version < Base
    property 'version_major', from: 'VersionMajor', transform_with: lambda(&:to_i)
    property 'version_minor', from: 'VersionMinor', transform_with: lambda(&:to_i)
    property 'build_major', from: 'BuildMajor', transform_with: lambda(&:to_i)
    property 'build_minor', from: 'BuildMinor', transform_with: lambda(&:to_i)
  end
end
