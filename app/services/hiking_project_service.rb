class HikingProjectService < ApplicationService

  def get_trails(lat, long)
    params = { lat: lat,
               lon: long }
    get_json('/data/get-trails', params)
  end

  private

  def conn
    Faraday.new('https://www.hikingproject.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['HIKING_PROJECT_API']
    end
  end

end
