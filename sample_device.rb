#!/usr/bin/ruby

require "httparty"
require "yaml"
require "pry"

host = ARGV[0]
url = host + "/locations.json"

equipment_id = ARGV[1]

options = { headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'} }

locations = YAML.load(File.read("sample_coordinates.yml"))

locations["route_1"].each do |coordinates|
  body = { equipment_id: equipment_id, location: { coordinates: coordinates } }

  response = HTTParty.post(
    url,
    body: body,
    options: options
  )

  unless response.success?
    binding.pry
  end
end

