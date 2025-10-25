# frozen_string_literal: true

module Tcx
  module Types
    # Device_t (extends AbstractSource_t)
    #
    # Represents a hardware device that created or recorded an activity, such as:
    #   - GPS watches (Garmin Forerunner, Fenix, etc.)
    #   - Cycling computers (Edge series)
    #   - Fitness trackers
    #   - Heart rate monitors
    #
    # Device information helps identify the source and capabilities of the recorded data.
    #
    # XSD Definition:
    #   - Name (Token_t): Device name (inherited from AbstractSource)
    #   - UnitId (unsignedInt): Unique device serial number
    #   - ProductID (unsignedShort): Garmin product identifier
    #   - Version (Version_t): Firmware/software version information
    #
    # @example Garmin Forerunner
    #   device = Device.new(
    #     'Name' => 'Garmin Forerunner 945',
    #     'UnitId' => '3580760363',
    #     'ProductID' => '2697',
    #     'Version' => { 'VersionMajor' => 5, 'VersionMinor' => 0 }
    #   )
    class Device < AbstractSource
      # Unique device serial number/identifier
      # @return [String] unit ID (typically numeric but stored as string)
      property 'unit_id', from: 'UnitId'

      # Garmin product ID that identifies the device model
      # @return [String] product identifier
      property 'product_id', from: 'ProductID'

      # Firmware or software version running on the device
      # @return [Version] version information object
      property 'version', from: 'Version', transform_with: ->(v) { Version.parse(v) }

      # Add xsi:type attribute for polymorphic XML serialization
      # @return [Hash] merged attributes including xsi:type
      def attributes
        super.merge('xsi:type' => 'Device_t')
      end
    end
  end
end
