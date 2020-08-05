require 'rails_helper'

describe DailyForecast, type: :model do
  describe "instance methods" do
    context '#get_precip' do
      it "gets precipitation" do
        test_forecast = [{ id: 600, main: "Snow", description: "light snow", icon: "13d" }]
        test_temperature = { max: 30.00, min: 20.00 }
        mock_daily = { dt: 1609600000, weather: test_forecast, snow: 15.00, temp: test_temperature }
        test_daily = DailyForecast.new(mock_daily)
        expect(test_daily.precip).to eq(15.00)
      end
    end
  end
end
