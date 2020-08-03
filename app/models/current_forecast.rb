class CurrentForecast < Forecast
  attr_reader :temp, :sunrise, :sunset,
              :visibility, :humidity, :uv, :feels_like

  def initialize(forecast)
    @time = forecast[:dt]
    @weather = forecast[:weather]
    @sunrise = forecast[:sunrise]
    @sunset = forecast[:sunset]
    @temp = forecast[:temp]
    @feels_like = forecast[:feels_like]
    @humidity = forecast[:humidity]
    @visibility = forecast[:visibility]
    @uv = forecast[:uvi]
  end
end
