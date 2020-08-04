class Api::V1::UsersController < ApplicationController
  def create
    user_data = JSON.parse(request.raw_post, symbolize_names: true)
    new_user = User.new(user_data)
    if new_user.save
      new_user.generate_api_key
      render json: UserSerializer.new(new_user), status: 201
    else
      error_message = new_user.errors.full_messages.to_sentence
      render json: { error: error_message }, status: 400
    end
  end
end
