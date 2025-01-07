#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title add-note
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📝
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }

require 'net/http'
require 'uri'
require 'json'

authorization_token = 'API_AUTHORIZATION_TOKEN' # Your API Authorization Token
url = 'API_URL' # Your API URL

uri = URI.parse("#{url}/notes")
request = Net::HTTP::Post.new(uri)
request.content_type = 'application/json'
request['Authorization'] = "Bearer #{authorization_token}"

request.body = {
  note: {
    body: ARGV[0]
  }
}.to_json

Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  res = http.request(request)

  if res.code != '200'
    puts "Error: #{res.code}"
    exit
  end
end

puts "note added"
