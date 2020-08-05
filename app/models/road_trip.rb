class RoadTrip

  attr_reader :id, :origin, :destination, :travel_time, :forecast

  def initialize(origin, destination)
    @id = nil
    @origin = origin
    @destination = destination
    @travel_time = nil
    @forecast = {}
  end

  def get_travel_time
    travel_data = MapquestService.new.get_distance(@origin, @destination)
    @travel_time = travel_data[:route][:formattedTime]
    travel_data[:route][:realTime]
  end

  def get_arrival_forecast(travel_time)
    geocode = MapquestService.new.get_geocode(@destination)
    coordinates = geocode[:results].first[:locations].first[:latLng]
    weather = OpenweatherService.new.get_forecast(coordinates[:lat],
                                                  coordinates[:lng])
    current_time = weather[:current][:dt]
    forecast_by_hour = weather[:hourly].map { |hour| HourlyForecast.new(hour) }
    @forecast = get_nearest_time(current_time, forecast_by_hour, travel_time)
    @forecast.convert_time(weather[:timezone_offset])
  end

  def get_nearest_time(current_time, forecasts, travel_time)
    arrival_time = current_time + travel_time
    forecasts.min_by { |forecast| (forecast.time - arrival_time).abs }
  end
end
