class Api::V1::ForecastController < ApplicationController
  def show
    forecast = WeatherForecast.new(params[:location])
    forecast.get_forecast
    binding.pry
    render json: WeatherForecastSerializer.new(forecast)
  end
end
