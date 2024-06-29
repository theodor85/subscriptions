require 'dry-struct'


module Types
  include Dry.Types()
end

class Config < Dry::Struct
  attribute :id, Types::Integer
  attribute :message, Types::String
  attribute :chat do
    attribute :id, Types::Integer
    attribute :sender, Types::String
  end
end

h = {id: 123, message: 'mhello', chat: {id: 234, sender: 'Пися'}}

c = Config.new h

puts c.chat


chat = Config::Chat.new h[:chat]
puts chat.sender
