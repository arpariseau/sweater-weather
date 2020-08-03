require 'rails_helper'

describe OpenweatherService do
  context "instance methods" do
    context "#get_forecast" do
      it "returns the weather forecast", :vcr do
        forecast_resp = OpenweatherService.new.get_forecast(33.441792, -94.037689)

        expect(forecast_resp).to be_a Hash
        expect(forecast_resp[:lat]).to eq(33.44)
        expect(forecast_resp[:lon]).to eq(-94.04)
        expect(forecast_resp[:timezone_offset]).to eq(-18000)

        current_forecast = forecast_resp[:current]
        expect(current_forecast).to be_a Hash
        expect(current_forecast).to have_key :dt
        expect(current_forecast).to have_key :sunrise
        expect(current_forecast).to have_key :sunset
        expect(current_forecast).to have_key :temp
        expect(current_forecast).to have_key :feels_like
        expect(current_forecast).to have_key :humidity
        expect(current_forecast).to have_key :visibility
        expect(current_forecast).to have_key :uvi
        expect(current_forecast[:weather]).to be_an Array

        hourly_forecast = forecast_resp[:hourly]
        expect(hourly_forecast).to be_an Array
        expect(hourly_forecast.first).to have_key :dt
        expect(hourly_forecast.first).to have_key :temp
        expect(hourly_forecast.first[:weather]).to be_an Array

        daily_forecast = forecast_resp[:daily]
        expect(daily_forecast).to be_an Array
        expect(daily_forecast.first).to have_key :dt
        expect(daily_forecast.first[:temp]).to have_key :min
        expect(daily_forecast.first[:temp]).to have_key :max
        expect(daily_forecast.first[:weather]).to be_an Array
      end
    end
  end
end
