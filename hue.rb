require 'net/http'
require 'uri'
require 'json'
require 'yaml'

# Simple script to turn on/off hue lights

# Reference documentation
# https://www.developers.meethue.com/documentation/getting-started
# https://ruby-doc.org/stdlib-2.2.1/libdoc/net/http/rdoc/Net/HTTP.html
# https://www.sitepoint.com/ruby-net-http-library/
# https://stackoverflow.com/questions/2024805/ruby-send-json-request
# https://stackoverflow.com/questions/11403728/how-can-i-send-an-http-put-request-in-ruby

yaml_options = YAML.load_file('huecreds.yaml')
apikey = yaml_options['hue_apikey']

baseuri = 'http://192.168.1.4:80/'
path = "api/#{apikey}/lights/1/state"
joined = baseuri + path
@uri_symbol = URI(joined)

puts apikey

on = {on: true}.to_json
off = {on: false}.to_json


def light1(lightstate)
  uri = @uri_symbol
  req = Net::HTTP::Put.new(uri, 'Content-Type' => 'application/json')
  req.body = lightstate
  puts req.body
  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
  end
end

light1(on)
