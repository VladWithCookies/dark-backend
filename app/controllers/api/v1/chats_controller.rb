class Api::V1::ChatsController < ApplicationController
  def index
    chats = Chat.all
    render json: ChatSerializer.new(chats, { include: [:messages] }).serialized_json
  end

  def create
    chat = Chat.new(chat_params)
    chat.users << current_user

    user_ids = params[:user_ids].delete(current_user.id)
    users = User.where(id: user_ids)
    chat.users.concat(users)

    if chat.save
      serialized_json = ChatSerializer.new(chat, { include: [:messages, :users] }).serialized_json
      ActionCable.server.broadcast('chats_channel', serialized_json)
      head :ok
    end
  end

  private

  def chat_params
    params.permit(:name)
  end
end
