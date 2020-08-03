require 'rails_helper'

describe 'an api request' do
  it 'can get trails' do
    get api_v1_trails_path, params: { location: "Denver,CO" }
    trails_resp = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(trails_resp[:type]).to eq("trail_list")
    expect(trails_resp[:attributes][:location]).to eq("Denver,CO")

    expect(trails_resp[:attributes][:forecast]).to have_key :summary
    expect(trails_resp[:attributes][:forecast]).to have_key :temperature

    trails = trails_resp[:attributes][:trails]

    expect(trails).to be_an Array
    expect(trails.first).to have_key :name
    expect(trails.first).to have_key :summary
    expect(trails.first).to have_key :difficulty
    expect(trails.first).to have_key :location
    expect(trails.first).to have_key :distance_to_trail
  end
end
