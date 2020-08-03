class Trail

  attr_reader :name, :summary, :difficulty, :location, :distance_to_trail

  def initialize(trail)
    @name = trail[:name]
    @summary = trail[:summary]
    @difficulty = trail[:difficulty]
    @location = trail[:location]
    @distance_to_trail = trail[:distance]
  end

end
