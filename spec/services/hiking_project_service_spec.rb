require 'rails_helper'

describe HikingProjectService do
  context "instance methods" do
    context "#get_trails" do
      it "returns a list of trails" do
        trails_resp = HikingProjectService.new.get_trails(40.0274, -105.2519)

        expect(trails_resp).to be_a Hash
        expect(trails_resp[:trails]).to be_an Array

        trail_data = trails_resp[:trails].first
        expect(trail_data).to be_a Hash
        expect(trail_data).to have_key :name
        expect(trail_data).to have_key :summary
        expect(trail_data).to have_key :difficulty
        expect(trail_data).to have_key :location
        expect(trail_data).to have_key :latitude
        expect(trail_data).to have_key :longitude
      end
    end
  end
end
