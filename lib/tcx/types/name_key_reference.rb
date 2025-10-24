# frozen_string_literal: true

module Tcx
  class NameKeyReference < Base
    property 'id', from: 'Id'
    property 'name', from: 'Name'
  end
end
