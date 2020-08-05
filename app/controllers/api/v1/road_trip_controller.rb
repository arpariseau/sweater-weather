class Api::V1::RoadTripController < ApplicationController
  def create
    road_trip_data = JSON.parse(request.raw_post, symbolize_names: true)
    if road_trip_data[:origin].nil? || road_trip_data[:destination].nil?
      render json: { error: "Incomplete information" }, status: 400
    elsif invalid_api_key?(road_trip_data[:api_key])
      render json: { error: "Unauthorized. Invalid API key" }, status: 401
    else
      road_trip = RoadTrip.new(road_trip_data[:origin],
                               road_trip_data[:destination])
      road_trip.get_arrival_forecast(road_trip.get_travel_time)
      render json: RoadTripSerializer.new(road_trip)
    end
  end

  private

  def invalid_api_key?(api_key)
    User.find_by(api_key: api_key).nil?
  end
end
