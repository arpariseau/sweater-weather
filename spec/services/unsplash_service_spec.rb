require 'rails_helper'

describe UnsplashService do
  context "instance methods" do
    context "#get_image" do
      it "returns image information", :vcr do
        image_resp = UnsplashService.new.get_image("Denver,CO", "Rain")

        expect(image_resp).to be_a Hash
        expect(image_resp[:results]).to be_an Array

        image_data = image_resp[:results].first
        expect(image_data).to have_key :links
        expect(image_data[:links]).to have_key :html
      end
    end
  end
end
