class WeatherForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :current, :hourly, :daily
end
