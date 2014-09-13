class Location
  include Mongoid::Document
  field :coordinates, type: Array

  index({ coordinates: "2d" }, { min: -200, max: 200 })
end
