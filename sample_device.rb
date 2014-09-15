#!/usr/bin/ruby

require "httparty"
require "yaml"
require "ruby-progressbar"
require "thor"
require "pry"

class SampleDevice < Thor
  desc "launch EQUIPMENT_ID", "Starts the sample device for pinging"
  option :host
  option :route

  def launch(host, equipment_id)
    host = options.fetch(:host) { "http://localhost:3000" }
    route = options.fetch(:route) { "route_2" }
    url = host + "/locations.json"

    http_options = { headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'} }

    locations = YAML.load(File.read("sample_coordinates.yml"))

    progress_bar = ProgressBar.create(
      format: '%a |%b>>%i| %p%% %t',
      total:  locations[route].count
    )

    locations[route].each do |coordinates|
      body = { location: { coordinates: coordinates, equipment_id: equipment_id } }

      response = HTTParty.post(
        url,
        body: body,
        options: http_options
      )

      if response.success?
        progress_bar.increment
        # sleep(5.0)
      else
        puts JSON.parse(response.body)
      end
    end
  end
end

SampleDevice.start(ARGV)

