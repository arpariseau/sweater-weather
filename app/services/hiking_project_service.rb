class HikingProjectService < ApplicationService

  def get_trails(lat, long)
    params = { lat: lat,
               lon: long }
    get_json('/data/get-trails', params)
  private

  def conn
    Faraday.new('http://www.hikingproject.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['HIKING_PROJECT_API']
    end
  end

end
