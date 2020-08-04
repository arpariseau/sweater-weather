class Api::V1::ForecastController < ApplicationController
  def show
    forecast = WeatherForecast.new(params[:location])
    forecast.get_forecast
    render json: WeatherForecastSerializer.new(forecast)
  end
end
