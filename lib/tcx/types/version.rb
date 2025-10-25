# frozen_string_literal: true

module Tcx
  # Version_t
  #
  # Represents a version number in the format: Major.Minor.Build.Patch
  # Used for both device firmware versions and application software versions.
  #
  # Follows semantic versioning principles:
  #   - Major version: Incompatible API changes
  #   - Minor version: Backwards-compatible functionality additions
  #   - Build major: Significant build updates
  #   - Build minor: Minor build updates/patches
  #
  # XSD Definition:
  #   - VersionMajor (unsignedShort): Major version number
  #   - VersionMinor (unsignedShort): Minor version number
  #   - BuildMajor (unsignedShort): Build major number (optional)
  #   - BuildMinor (unsignedShort): Build minor number (optional)
  #
  # @example Device firmware version
  #   version = Version.new(
  #     'VersionMajor' => 5,
  #     'VersionMinor' => 0,
  #     'BuildMajor' => 0,
  #     'BuildMinor' => 0
  #   )
  #   # Represents version 5.0.0.0
  class Version < Base
    # Major version number (first number in version string)
    # @return [Integer] major version
    property 'version_major', from: 'VersionMajor', transform_with: lambda(&:to_i)

    # Minor version number (second number in version string)
    # @return [Integer] minor version
    property 'version_minor', from: 'VersionMinor', transform_with: lambda(&:to_i)

    # Build major number (third number in version string)
    # @return [Integer, nil] build major or nil
    property 'build_major', from: 'BuildMajor', transform_with: lambda(&:to_i)

    # Build minor number (fourth number in version string)
    # @return [Integer, nil] build minor or nil
    property 'build_minor', from: 'BuildMinor', transform_with: lambda(&:to_i)
  end
end
