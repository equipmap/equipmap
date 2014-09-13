#!/usr/bin/ruby

require "httparty"
require "yaml"
require "pry"
require "ruby-progressbar"

host = ARGV[0]
url = host + "/locations.json"

equipment_id = ARGV[1]

key = ARGV.fetch(2) { "route_2" }

options = { headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'} }

locations = YAML.load(File.read("sample_coordinates.yml"))

progress_bar = ProgressBar.create(
  format: '%a |%b>>%i| %p%% %t',
  total:  locations[key].count
)

locations[key].each do |coordinates|
  body = { location: { coordinates: coordinates, equipment_id: equipment_id } }

  response = HTTParty.post(
    url,
    body: body,
    options: options
  )

  if response.success?
    progress_bar.increment
    sleep(5.0)
  else
    puts JSON.parse(response.body)
  end
end

