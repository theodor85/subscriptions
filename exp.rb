# frozen_string_literal: true

require 'dry-struct'
require 'json'

module Exp
  module Types
    include Dry.Types()
  end

  class SymbolizeStruct < Dry::Struct
    transform_keys(&:to_sym)
  end

  class User < SymbolizeStruct
    attribute :id, Types::Integer
    attribute :username, Types::String
  end

  class Collection < SymbolizeStruct
    attribute :users, Types::Array.of(User)
  end
end

# users = Exp::Collection.new(users: [Exp::User.new(id: 1, username: 'user1'), Exp::User.new(id: 2, username: 'user2')])

# puts users

# puts users.to_h.to_json

user = Exp::User.new(id: 1, username: 'user1')
puts user.username
