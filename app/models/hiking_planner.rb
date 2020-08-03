class HikingPlanner

  attr_reader :location, :forecast, :trails

  def initialize(location)
    @location = location
    @forecast = {}
    @trails = []
  end

  def get_coordinates
    geocode = MapquestService.new.get_geocode(@location)
    geocode[:results].first[:locations].first[:latLng]
  end

  def get_forecast
    coordinates = get_coordinates
    weather = OpenweatherService.new.get_forecast(coordinates[:lat],
                                                  coordinates[:lng])
    @forecast[:summary] = weather[:current][:weather].first[:description]
    @forecast[:temperature] = weather[:current][:temp]
  end

  def get_trails
    coordinates = get_coordinates
    @trails = HikingProjectService.new.get_trails(coordinates[:lat],
                                                  coordinates[:lng])[:trails]
    @trails.map! { |trail| Trail.new(trail) }
  end

end
