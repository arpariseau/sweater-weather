require 'rails_helper'

describe 'an api request' do
  it 'can get forecast' do
    get api_v1_forecast_path, params: { location: "Denver,CO" }
    forecast_resp = JSON.parse(response.body, symbolize_names: true)[:data]

    forecast = forecast_resp[:attributes]
    expect(forecast).to have_key :location
    expect(forecast).to have_key :current
    expect(forecast).to have_key :daily
    expect(forecast).to have_key :hourly
  end
end
