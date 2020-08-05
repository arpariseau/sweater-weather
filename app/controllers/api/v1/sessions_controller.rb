class Api::V1::SessionsController < ApplicationController
  def create
    login_data = JSON.parse(request.raw_post, symbolize_names: true)
    user = User.find_by(email: login_data[:email])
    if user.nil?
      render json: { error: "User not found" }, status: 404
    elsif user.authenticate(login_data[:password])
      render json: UserSerializer.new(user)
    else
      render json: { error: "Invalid password" }, status: 401
    end
  end
end
