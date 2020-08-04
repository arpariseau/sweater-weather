require 'rails_helper'

describe BackgroundImage, type: :model do
  describe "instance methods" do
    context '#get_image' do
      it 'gets a background image', :vcr do
        background = BackgroundImage.new
        background.get_image("Denver,CO", "Rain")
        expect(background.image).to eq("https://unsplash.com/photos/COFHE5jbC5s")
      end
    end
  end
end
