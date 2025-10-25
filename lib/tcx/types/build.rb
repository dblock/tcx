# frozen_string_literal: true

module Tcx
  # Build_t
  #
  # Contains build metadata for an Application, including version, build type,
  # build timestamp, and builder identifier.
  #
  # This information helps track which specific build of software created a TCX file,
  # useful for debugging and compatibility purposes.
  #
  # XSD Definition:
  #   - Version (Version_t): Version number information
  #   - Type (BuildType_t): Build type (Internal, Alpha, Beta, Release)
  #   - Time (Token_t): Build timestamp (optional, format varies)
  #   - Builder (Token_t): Builder identifier (optional, e.g., username or build system)
  #
  # @example Release build
  #   build = Build.new(
  #     'Version' => { 'VersionMajor' => 3, 'VersionMinor' => 4, 'BuildMajor' => 3 },
  #     'Type' => 'Release',
  #     'Time' => 'May 20 2008, 16:58:11',
  #     'Builder' => 'sqa'
  #   )
  class Build < Base
    # Version number information (major.minor.build)
    # @return [Version] version object
    property 'version', from: 'Version', transform_with: ->(v) { Version.parse(v) }

    # Type of build (Internal, Alpha, Beta, or Release)
    # @return [BuildType, nil] build type enumeration or nil
    property 'type', from: 'Type', transform_with: ->(v) { BuildType.parse(v) }

    # When this build was created (format varies, often human-readable)
    # @return [Time, nil] build timestamp or nil
    property 'time', from: 'Time', transform_with: ->(v) { ::Time.parse(v) }

    # Identifier of who/what created the build (username, build server, etc.)
    # @return [String, nil] builder identifier or nil
    property 'builder', from: 'Builder'
  end
end
