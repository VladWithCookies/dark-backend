class Api::V1::ChatsController < ApplicationController
  def index
    chats = Chat.all
    render json: ChatSerializer.new(chats, { include: [:messages] }).serialized_json
  end

  def create
    chat = current_user.chats.new(chat_params)

    if chat.save
      serialized_json = ChatSerializer.new(chat, { include: [{ messages: [:user] }] }).serialized_json
      ActionCable.server.broadcast('chats_channel', serialized_json)
      head :ok
    end
  end

  private

  def chat_params
    params.permit(:name)
  end
end
