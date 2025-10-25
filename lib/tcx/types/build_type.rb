# frozen_string_literal: true

module Tcx
  module Types
    # BuildType_t (simple type, enumeration)
    #
    # Indicates the maturity level or stage of a software build.
    #
    # XSD Definition (restriction of xsd:token):
    #   - Internal: Internal development build (not for external release)
    #   - Alpha: Early testing phase build (feature incomplete, unstable)
    #   - Beta: Feature-complete testing build (may have bugs)
    #   - Release: Production-ready public release
    #
    # @example
    #   BuildType.parse('Release')  # => BuildType::RELEASE
    #   BuildType::BETA             # => 'Beta'
    class BuildType
      include Ruby::Enum

      # Internal development build
      define :internal, 'Internal'

      # Alpha testing build
      define :alpha, 'Alpha'

      # Beta testing build
      define :beta, 'Beta'

      # Production release build
      define :release, 'Release'
    end
  end
end
