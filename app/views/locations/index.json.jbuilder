json.array!(@locations) do |location|
  json.extract! location, :id, :coordinates, :equipment_id, :created_at
  json.url location_url(location, format: :json)
end
