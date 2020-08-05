require 'rails_helper'

describe 'an api request' do
  it 'can login a user' do
    user = create(:user)
    post_body = { "email": user.email,
                  "password": user.password }
    post api_v1_sessions_path, params: post_body, as: :json
    expect(response.status).to eq(200)
    user_resp = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(user_resp[:type]).to eq("user")
    expect(user_resp[:id].to_i).to eq(user.id)

    user_attr = user_resp[:attributes]
    expect(user_attr[:email]).to eq(user.email)
    expect(user_attr[:api_key]).to eq(user.api_key)
  end

  it "tries to login a user that doesn't exist" do
    post_body = { "email": "whatever@example.com",
                  "password": "password" }
    post api_v1_sessions_path, params: post_body, as: :json
    expect(response.status).to eq(404)
    error_resp = JSON.parse(response.body, symbolize_names: true)

    expect(error_resp[:error]).to eq("User not found")
  end

  it 'tries to login with a faulty password' do
    user = create(:user, password: "password", password_confirmation: "password")
    post_body = { "email": user.email,
                  "password": "notpassword" }
    post api_v1_sessions_path, params: post_body, as: :json
    expect(response.status).to eq(401)
    error_resp = JSON.parse(response.body, symbolize_names: true)

    expect(error_resp[:error]).to eq("Invalid password")
  end

end
