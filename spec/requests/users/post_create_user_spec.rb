require 'rails_helper'

describe 'an api request' do
  it 'can create a user' do
    post_body = { "email": "whatever@example.com",
                  "password": "password",
                  "password_confirmation": "password" }
    post api_v1_users_path, params: post_body, as: :json
    expect(response.status).to eq(201)
    user_resp = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(user_resp[:type]).to eq("user")
    expect(user_resp).to have_key :id

    user_attr = user_resp[:attributes]
    expect(user_attr[:email]).to eq("whatever@example.com")
    expect(user_attr[:api_key]).to_not be_empty
  end

  it 'gives an error if email is not unique' do
    user = create(:user)
    post_body = { "email": user.email,
                  "password": "password",
                  "password_confirmation": "password" }
    post api_v1_users_path, params: post_body, as: :json
    expect(response.status).to eq(400)
    error_resp = JSON.parse(response.body, symbolize_names: true)

    expect(error_resp[:error]).to eq("Email has already been taken")
  end

  it "gives an error when password doesn't match confirmation" do
    post_body = { "email": "whatever@example.com",
                  "password": "password",
                  "password_confirmation": "notpassword" }
    post api_v1_users_path, params: post_body, as: :json
    expect(response.status).to eq(400)
    error_resp = JSON.parse(response.body, symbolize_names: true)

    expect(error_resp[:error]).to eq("Password confirmation doesn't match Password")
  end

  it "gives an error when one of the information pieces is blank" do
    post_body = { "email": "whatever@example.com",
                  "password": "password" }
    post api_v1_users_path, params: post_body, as: :json
    expect(response.status).to eq(400)
    error_resp = JSON.parse(response.body, symbolize_names: true)

    expect(error_resp[:error]).to eq("Password confirmation can't be blank")
  end
end
