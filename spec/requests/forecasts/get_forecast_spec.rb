require 'rails_helper'

describe 'an api request' do
  it 'can get forecast', :vcr do
    get api_v1_forecast_path, params: { location: "Denver,CO" }
    forecast_resp = JSON.parse(response.body, symbolize_names: true)[:data]

    forecast = forecast_resp[:attributes]
    expect(forecast[:location]).to eq("Denver,CO")

    current = forecast[:current]
    expect(current).to have_key :time
    expect(current).to have_key :sunrise
    expect(current).to have_key :sunset
    expect(current).to have_key :temp
    expect(current).to have_key :feels_like
    expect(current).to have_key :visibility
    expect(current).to have_key :humidity
    expect(current).to have_key :visibility
    expect(current).to have_key :weather

    daily = forecast[:daily].first
    expect(daily).to have_key :time
    expect(daily).to have_key :high
    expect(daily).to have_key :low
    expect(daily).to have_key :precip
    expect(daily).to have_key :weather

    hourly = forecast[:hourly].first
    expect(hourly).to have_key :time
    expect(hourly).to have_key :temp
    expect(hourly).to have_key :weather
  end
end
