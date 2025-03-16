# frozen_string_literal: true

require 'dry-struct'

module Subscriptions
  module Types
    include Dry.Types()
  end

  class Config < Dry::Struct
    attribute :tg_token, Types::String
    attribute :tg_url, Types::String
    attribute :tg_bot_id, Types::String
    attribute :webhook_secret_token, Types::String
    attribute :webhook_url, Types::String
  end
end
