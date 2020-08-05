class MapquestService < ApplicationService

  def get_geocode(location)
    params = { location: location }
    get_json('/geocoding/v1/address', params)
  end

  def travel_distance(origin, destination)
    params = { from: origin,
               to: destination }
    get_json('/directions/v2/route', params)
  end

  private

  def conn
    Faraday.new('http://www.mapquestapi.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end
end
