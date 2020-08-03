class DailyForecast < Forecast
  attr_reader :high, :low, :precip

  def initialize(forecast)
    @time = forecast[:dt]
    @weather = forecast[:weather]
    @high = forecast[:temp][:max]
    @low = forecast[:temp][:min]
    @precip = find_precip(forecast)
  end

  def find_precip(forecast)
    weather_type = @weather.map { |info| info[:main] }
    if weather_type.include?("Rain")
      return forecast[:rain]
    elsif weather_type.include?("Snow")
      return forecast[:snow]
    else
      return 0
    end
  end
end
