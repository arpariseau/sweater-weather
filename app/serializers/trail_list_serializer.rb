class TrailListSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :forecast, :trails
end
