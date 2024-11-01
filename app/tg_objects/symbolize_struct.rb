# frozen_string_literal: true

require 'dry-struct'

module TgObjects
  module Types
    include Dry.Types()
  end

  class SymbolizeStruct < Dry::Struct
    transform_keys(&:to_sym)
  end
end
