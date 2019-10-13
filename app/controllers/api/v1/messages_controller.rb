class Api::V1::MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    chat = Chat.find(params[:chat_id])
    message.chat = chat
    message.user = current_user

    if message.save
      serialized_json = MessageSerializer.new(message).serialized_json
      MessagesChannel.broadcast_to(chat, serialized_json)
      head :ok
    end
  end

  private

  def message_params
    params.permit(:text)
  end
end
