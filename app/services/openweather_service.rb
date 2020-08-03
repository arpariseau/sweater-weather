class OpenweatherService < ApplicationService

  def get_forecast(lat, long)
    params = { lat: lat,
               lon: long,
               exclude: 'minutely',
               units: 'imperial' }
    get_json('/data/2.5/onecall', params)
  end

  private

  def conn
    Faraday.new('https://api.openweathermap.org') do |f|
      f.adapter Faraday.default_adapter
      f.params[:appid] = ENV['OPENWEATHER_API_KEY']
    end
  end
end
