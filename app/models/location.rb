class Location
  include Mongoid::Document
  include Mongoid::Timestamps

  field :coordinates, type: Array
  index({ coordinates: "2d" }, { min: -200, max: 200 })

  belongs_to :equipment
  validates :equipment, presence: true
end
