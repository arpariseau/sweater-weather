class Forecast
  attr_reader :time, :weather

  def convert_time(timezone)
    @time = DateTime.strptime((@time + timezone).to_s, "%s" )
  end
end
