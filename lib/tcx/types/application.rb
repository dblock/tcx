# frozen_string_literal: true

module Tcx
  module Types
    # Application_t (extends AbstractSource_t)
    #
    # Represents a software application that created or authored a TCX file, such as:
    #   - Garmin Training Center
    #   - Garmin Connect
    #   - Third-party training software
    #   - Mobile apps
    #
    # Application information typically appears in the Author field of the root database,
    # identifying the software that created or last modified the TCX file.
    #
    # XSD Definition:
    #   - Name (Token_t): Application name (inherited from AbstractSource)
    #   - Build (Build_t): Build information (version, type, time, builder)
    #   - LangID (LangID_t): Language identifier (e.g., "EN", "DE", "FR")
    #   - PartNumber (PartNumber_t): Software part/SKU number
    #
    # @example Garmin Training Center
    #   app = Application.new(
    #     'Name' => 'Garmin Training Center(r)',
    #     'LangID' => 'EN',
    #     'PartNumber' => '006-A0119-00',
    #     'Build' => { 'Version' => { 'VersionMajor' => 3, 'VersionMinor' => 4 }}
    #   )
    class Application < AbstractSource
      # Build information including version, type, timestamp, and builder
      # @return [Build] build information object
      property 'build', from: 'Build', transform_with: ->(v) { Build.parse(v) }

      # Language identifier for the application's localization
      # @return [String] language code (e.g., "EN", "DE", "FR")
      property 'lang_id', from: 'LangID'

      # Software part number or SKU
      # @return [String] part number identifier
      property 'part_number', from: 'PartNumber'

      # Add xsi:type attribute for polymorphic XML serialization
      # @return [Hash] merged attributes including xsi:type
      def attributes
        super.merge('xsi:type' => 'Application_t')
      end
    end
  end
end
