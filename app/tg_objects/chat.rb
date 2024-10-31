# frozen_string_literal: true

require 'dry-struct'
require_relative 'symbolize_struct'

module Subscriptions
  module TgObjects
    class Chat < SymbolizeStruct
      attribute :id, Types::Integer
      attribute? :first_name, Types::String
      attribute? :last_name, Types::String
      attribute? :username, Types::String
      attribute :type, Types::String
    end
  end
end
