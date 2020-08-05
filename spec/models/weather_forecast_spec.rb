require 'rails_helper'

describe WeatherForecast, type: :model do
  describe "instance methods" do
    before :each do
      @forecast = WeatherForecast.new("Denver,CO")
    end

    context '#get_coordinates' do
      it "gets latitude and longitude", :vcr do
        coordinates = @forecast.get_coordinates
        expect(coordinates).to have_key :lat
        expect(coordinates).to have_key :lng
      end
    end

    context '#get_forecast' do
      it "gets a complete forecast", :vcr do
        @forecast.get_forecast
        expect(@forecast.location).to eq("Denver,CO")
        expect(@forecast.current).to be_a CurrentForecast
        expect(@forecast.hourly).to be_an Array
        expect(@forecast.hourly.first).to be_a HourlyForecast
        expect(@forecast.daily).to be_an Array
        expect(@forecast.daily.first).to be_a DailyForecast
      end
    end

    context '#convert_times' do
      it "converts Unix times to datetimes", :vcr do
        @forecast.get_forecast
        expect(@forecast.current.time).to be_a DateTime
        expect(@forecast.hourly.first.time).to be_a DateTime
        expect(@forecast.daily.first.time).to be_a DateTime
      end
    end

  end
end
