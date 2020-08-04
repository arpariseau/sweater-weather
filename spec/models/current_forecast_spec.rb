require 'rails_helper'

describe CurrentForecast, type: :model do
  describe "instance methods" do
    context '#get_weather' do
      it "gets the weather", :vcr do
        forecast = WeatherForecast.new("Denver,CO")
        forecast.get_forecast
        current = forecast.current
        expect(current.get_weather).to eq("Clouds")
      end
    end
  end
end
