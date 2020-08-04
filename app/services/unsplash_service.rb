class UnsplashService < ApplicationService

  def get_image(location, weather)
    params = { query: "#{location}+#{weather}" }
    get_json('/search/photos', params)
  end

  private

  def conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:client_id] = ENV['UNSPLASH_API_KEY']
    end
  end
end
