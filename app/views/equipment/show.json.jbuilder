json.extract! @equipment, :id, :project_id, :name, :description, :created_at, :updated_at, :current_location
json.previous_coordinates @equipment.locations.order("created_at DESC").limit(10).map(&:coordinates).reverse
