require 'rails_helper'

describe 'an api request' do
  it 'can get forecast' do
    get api_v1_forecast_path, params: { location: "Denver,CO" }
    forecast_resp = JSON.parse(response.body, symbolize_names: true)[:data]
    binding.pry
  end
end
