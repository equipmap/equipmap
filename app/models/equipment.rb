class Equipment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String

  has_many :locations
  belongs_to :project

  def current_location
    locations.last
  end
end
