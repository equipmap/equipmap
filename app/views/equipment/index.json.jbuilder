json.array!(@equipment) do |equipment|
  json.extract! equipment, :id, :project_id, :name, :description, :current_location
  json.previous_coordinates equipment.locations.order("created_at DESC").map(&:coordinates).reverse
  json.url equipment_url(equipment, format: :json)
end
