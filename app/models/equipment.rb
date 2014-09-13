class Equipment
  include Mongoid::Document
  field :name, type: String
  field :description, type: String

  has_many :locations
  belongs_to :project
end
