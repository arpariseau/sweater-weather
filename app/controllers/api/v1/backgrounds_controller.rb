class Api::V1::BackgroundsController < ApplicationController
  def show
    forecast = WeatherForecast.new(params[:location])
    forecast.get_forecast
    weather = forecast.current.get_weather
    background = BackgroundImage.new
    background.get_image(params[:location], weather)
    render json: BackgroundImageSerializer.new(background)
  end
end
