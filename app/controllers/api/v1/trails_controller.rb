class Api::V1::TrailsController < ApplicationController
  def index
    trails = TrailList.new(params[:location])
    trails.get_forecast
    trails.get_trails
    render json: TrailListSerializer.new(trails)
  end
end
