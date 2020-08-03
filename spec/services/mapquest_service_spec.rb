require 'rails_helper'

describe MapquestService do
  context "instance methods" do
    context "#get_geocode" do
      it "returns latitude and longitude" do
        location_resp = MapquestService.new.get_geocode("Washington,DC")

        expect(location_resp).to be_a Hash
        expect(location_resp[:results]).to be_an Array

        results_data = location_resp[:results].first
        expect(results_data).to be_a Hash
        expect(results_data[:providedLocation][:location]).to eq("Washington,DC")
        expect(results_data[:locations]).to be_an Array

        location_data = results_data[:locations].first
        expect(location_data[:latLng]).to be_a Hash
        expect(location_data[:latLng][:lat]).to eq(38.892062)
        expect(location_data[:latLng][:lng]).to eq(-77.019912)
      end
    end

    context '#get_distance' do
      it "returns distance between a location and coordinates" do
        location_resp = MapquestService.new.get_distance("Denver", 39.9388, -105.2582)

        expect(location_resp).to be_a Hash
        expect(location_resp[:route]).to be_a Hash
        expect(location_resp[:route]).to have_key :distance
      end
    end
  end
end
