require 'dry/monads'
require_relative './tg_objects/update'

module Subscriptions
  class Router
    attr_reader :update

    include ::Dry::Monads[:result]
    include Import[:message_parser]

    def call(params)
      # парсим объект update
      # парсим текст сообщения, в зависимости от команды получаем нужную операуию
      # результат операции возвращаем наверх в виде ответного сообщения для отправки

      @update = Subscriptions::TgObjects::Update.new(params[:update])
      return nil unless update_has_message?

      return { chat_id:, message: parse_result.failure } unless parse_result.success?

      case operation.(update.message.text)
      in Success(answer)
        { chat_id:, message: answer }
      in Failure(error)
        { chat_id:, message: error }
      end
    end

    private

    def parse_result
      @parse_result ||= message_parser.(update.message.text)
    end

    def operation
      parse_result.value!
    end

    def update_has_message?
      !update.message.nil?
    end

    def chat_id
      update.message.chat.id
    end
  end
end
