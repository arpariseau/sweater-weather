require 'rails_helper'

describe TrailList, type: :model do
  describe "instance methods" do
    before :each do
      @trail_list = TrailList.new("Denver,CO")
    end

    context '#get_coordinates' do
      it "gets latitude and longitude" do
        coordinates = @trail_list.get_coordinates
        expect(coordinates).to have_key :lat
        expect(coordinates).to have_key :lng
      end
    end

    context '#get_forecast' do
      it "gets a basic forecast" do
        @trail_list.get_forecast
        expect(@trail_list.forecast).to have_key :summary
        expect(@trail_list.forecast).to have_key :temperature
      end
    end

    context 'get_trails' do
      it "gets a list of trails" do
        @trail_list.get_trails
        expect(@trail_list.trails.first).to be_a Trail
      end
    end

    context 'get_distance' do
      it "gets distance to the trailhead" do
        trails = HikingProjectService.new.get_trails(40.0274, -105.2519)
        test_trails = @trail_list.get_distance(trails[:trails])
        expect(test_trails.first).to have_key :distance
      end
    end

  end
end
