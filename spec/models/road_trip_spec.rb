require 'rails_helper'

describe RoadTrip, type: :model do
  describe "instance methods" do
    before :each do
      @road_trip = RoadTrip.new("Denver,CO", "Pueblo,CO")
    end

    context '#get_travel_time' do
      it "gets the travel time for the road trip", :vcr do
        time = @road_trip.get_travel_time
        expect(@road_trip.travel_time).to eq("01:43:57")
        expect(time).to eq(6480)
      end
    end

    context '#get_arrival_forecast' do
      it "gets forecast for when you arrive", :vcr do
        @road_trip.get_arrival_forecast(6500)
        expect(@road_trip.forecast).to be_a HourlyForecast
      end
    end

    context '#get_nearest_time' do
      it "finds the hourly forecast nearest arrival time" do
        test_forecast = [{ id: 301, main: "Drizzle", description: "drizzle", icon: "09n" }]
        alt_forecast = [{ id: 500, main: "Rain", description: "light rain", icon: "10n" }]
        first_hour = { dt: 1596596400, weather: test_forecast, temp: 72.00 }
        second_hour = { dt: 1596600000, weather: alt_forecast, temp: 70.00 }
        current_time = 1596590000
        travel_time = 6500
        forecasts = [HourlyForecast.new(first_hour), HourlyForecast.new(second_hour)]
        test_arrival = @road_trip.get_nearest_time(current_time, forecasts, travel_time)
        expect(test_arrival.temp).to eq(72)
        expect(test_arrival.weather).to eq(test_forecast)

        new_time = 9000
        alt_arrival = @road_trip.get_nearest_time(current_time, forecasts, new_time)
        expect(alt_arrival.temp).to eq(70)
        expect(alt_arrival.weather).to eq(alt_forecast)
      end
    end

  end
end
