# frozen_string_literal: true

module Tcx
  # AbstractSource_t
  #
  # Abstract base class for identifying the creator of a TCX file or activity.
  # Concrete implementations are Device_t (for hardware devices like GPS watches) and
  # Application_t (for software applications like Garmin Training Center).
  #
  # This type uses XML Schema's xsi:type attribute for polymorphism, allowing the
  # same Creator element to contain either device or application information.
  #
  # XSD Definition:
  #   - Name (Token_t): Name of the device or application
  #
  # Note: This is marked as abstract="true" in the XSD, meaning it should not be
  # instantiated directly. Use Device or Application instead.
  #
  # @example Polymorphic usage
  #   # As Device
  #   creator = AbstractSource.parse(xml_element)  # Returns Device instance
  #   # As Application
  #   creator = AbstractSource.parse(xml_element)  # Returns Application instance
  #
  # @see Device
  # @see Application
  class AbstractSource < Base
    # Name of the device or application
    # @return [String] name identifier
    property 'name', from: 'Name'
  end
end
