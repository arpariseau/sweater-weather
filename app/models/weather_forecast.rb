class WeatherForecast

  attr_reader :id, :location, :current, :hourly, :daily

  def initialize(location)
    @id = 0
    @location = location
    @current = nil
    @hourly = []
    @daily = []
  end

  def get_coordinates
    geocode = MapquestService.new.get_geocode(@location)
    coordinates = geocode[:results].first[:locations].first
    coordinates[:latLng]
  end

  def get_forecast
    coordinates = get_coordinates
    weather = OpenweatherService.new.get_forecast(coordinates[:lat],
                                                  coordinates[:lng])
    @current = CurrentForecast.new(weather[:current])
    @hourly = weather[:hourly].map { |hour| HourlyForecast.new(hour) }
    @daily = weather[:daily].map { |day| DailyForecast.new(day) }
    convert_times(weather[:timezone_offset])
  end

  def convert_times(timezone)
    @current.convert_time(timezone)
    @hourly.each { |hour_forecast| hour_forecast.convert_time(timezone) }
    @daily.each { |day_forecast| day_forecast.convert_time(timezone) }
  end

end
