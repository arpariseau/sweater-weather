class HourlyForecast < Forecast
  attr_reader :temp

  def initialize(forecast)
    @time = forecast[:dt]
    @weather = forecast[:weather]
    @temp = forecast[:temp]
  end
end
