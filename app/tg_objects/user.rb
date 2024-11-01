# frozen_string_literal: true

require 'dry-struct'
require_relative 'symbolize_struct'

module TgObjects
  class User < SymbolizeStruct
    attribute :id, Types::Integer
    attribute :is_bot, Types::Bool
    attribute :first_name, Types::String
    attribute? :last_name, Types::String
    attribute? :username, Types::String
    attribute? :language_code, Types::String
  end
end
