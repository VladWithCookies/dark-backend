class Api::V1::CurrentUsersController < ApplicationController
  def index
    render json: UserSerializer.new(current_user).serialized_json
  end
end
