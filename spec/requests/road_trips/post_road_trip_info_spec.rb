require 'rails_helper'

describe 'an api request' do
  it 'can get road trip information', :vcr do
    user = create(:user)
    post_body = { "origin": "Denver,CO",
                  "destination": "Pueblo,CO",
                  "api_key": user.api_key }
    post api_v1_road_trip_index_path, params: post_body, as: :json
    expect(response.status).to eq(200)
    trip_resp = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(trip_resp[:origin]).to eq("Denver,CO")
    expect(trip_resp[:destination]).to eq("Pueblo,CO")
    expect(trip_resp).to have_key :travel_time

    arrival_forecast = trip_resp[:forecast]
    expect(arrival_forecast).to have_key(:temp)
    expect(arrival_forecast).to have_key(:weather)
  end

  it 'does not authorize invalid api keys' do
    create(:user, api_key: "pretendthisisavalidapikey")
    post_body = { "origin": "Denver,CO",
                  "destination": "Pueblo,CO",
                  "api_key": "thisisnotavalidapikey" }
    post api_v1_road_trip_index_path, params: post_body, as: :json
    expect(response.status).to eq(401)
    error_resp = JSON.parse(response.body, symbolize_names: true)

    expect(error_resp[:error]).to eq("Unauthorized. Invalid API key")
  end

  it "errors if there's missing information" do
    user = create(:user)
    no_destination = { "origin": "Denver,CO",
                       "api_key": user.api_key }
    post api_v1_road_trip_index_path, params: no_destination, as: :json
    expect(response.status).to eq(400)
    dest_error_resp = JSON.parse(response.body, symbolize_names: true)

    expect(dest_error_resp[:error]).to eq("Incomplete information")

    no_origin = { "destination": "Pueblo,CO",
                  "api_key": user.api_key }
    post api_v1_road_trip_index_path, params: no_origin, as: :json
    expect(response.status).to eq(400)
    orig_error_resp = JSON.parse(response.body, symbolize_names: true)

    expect(orig_error_resp[:error]).to eq("Incomplete information")
  end
end
