#!/usr/bin/ruby

require "httparty"
require "yaml"
require "pry"

host = ARGV[0]
url = host + "/locations.json"

equipment_id = ARGV[1]

options = { headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'} }

locations = YAML.load(File.read("sample_coordinates.yml"))

locations["route_2"].each do |coordinates|
  body = { location: { coordinates: coordinates, equipment_id: equipment_id } }

  response = HTTParty.post(
    url,
    body: body,
    options: options
  )

  if response.success?
    sleep(5.0)
  else
    binding.pry
  end
end

