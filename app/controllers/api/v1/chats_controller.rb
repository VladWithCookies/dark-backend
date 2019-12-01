class Api::V1::ChatsController < ApplicationController
  def index
    chats = Chat.all
    render json: ChatSerializer.new(chats, { include: [:messages] }).serialized_json
  end

  def create
    user_ids = params[:user_ids]

    chat = if user_ids.count == 1
      Chat.includes(:users).find_by(users: { id: user_ids })
    end

    unless chat
      chat = Chat.new(chat_params)
      chat.users << current_user
      users = User.where(id: user_ids)
      chat.users.concat(users)
      chat.save
    end

    serialized_json = ChatSerializer.new(chat, { include: [:messages, :users] }).serialized_json
    ActionCable.server.broadcast('chats_channel', serialized_json)
    head :ok
  end

  private

  def chat_params
    params.permit(:name)
  end
end
