class BackgroundImage

  attr_reader :id, :image

  def initialize
    @id = nil
    @image = ""
  end

  def get_image(location, weather)
    image_resp = UnsplashService.new.get_image(location, weather)
    @image = image_resp[:results].first[:links][:html]
  end

end
