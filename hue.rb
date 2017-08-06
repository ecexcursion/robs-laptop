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

def generate_url(bulb)
  baseuri = 'http://192.168.1.4:80/'
  load_yaml = YAML.load_file('huecreds.yaml')
  apikey = load_yaml['hue_apikey']
  path = "api/#{apikey}/lights/#{bulb}/state"
  joined = baseuri + path
  puts apikey
  puts joined
  URI(joined)
end

def lights(bulb, lightstate)
  uri = generate_url(bulb)
  req = Net::HTTP::Put.new(uri, 'Content-Type' => 'application/json')
  req.body = lightstate
  puts "bulb " + bulb + " " + req.body
  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
  end
end

# define json body for on/off function
on = {on: true}.to_json
off = {on: false}.to_json

# Get user input passed in from console
#   format is "ruby scriptname light_number state"
#   example: "ruby hue.rb 1 on"

light_num = ARGV[0]
light_state = ARGV[1]

if light_state == 'on'
  lights(light_num, on)
end
if light_state == 'off'
  lights(light_num, off)
end

# lights('1', on)
