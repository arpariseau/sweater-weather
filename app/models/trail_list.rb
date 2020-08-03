class TrailList

  attr_reader :id, :location, :forecast, :trails

  def initialize(location)
    @id = nil
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
    api_trails = HikingProjectService.new.get_trails(coordinates[:lat],
                                                    coordinates[:lng])[:trails]
    @trails = get_distance(api_trails)
    @trails.map! { |trail| Trail.new(trail) }
  end

  def get_distance(trail_list)
    trail_list.each do |trail|
       route = MapquestService.new.get_distance(@location, trail[:latitude],
                                                trail[:longitude])[:route]
       trail[:distance] = route[:distance]
    end
  end

end
