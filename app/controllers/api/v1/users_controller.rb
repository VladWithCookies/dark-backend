class Api::V1::UsersController < ApplicationController
  def index
    users = User.where.not(id: current_user.id)
    render json: UserSerializer.new(users).serialized_json
  end
end
