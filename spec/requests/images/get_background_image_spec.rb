require 'rails_helper'

describe 'an api request' do
  it 'can get a background image', :vcr do
    get api_v1_backgrounds_path, params: { location: "Denver,CO" }
    image_resp = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(image_resp).to have_key :image
  end
end
