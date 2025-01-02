#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title english-words
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }

require 'net/http'
require 'uri'
require 'json'

authorization_token = 'API_AUTHORIZATION_TOKEN' # Your API Authorization Token
url = 'CREATE_WORD_SEARCH_API_URL' # Your API URL

uri = URI.parse(url)
request = Net::HTTP::Post.new(uri)
request.content_type = 'application/json'
request['Authorization'] = "Bearer #{authorization_token}"

request.body = {
  word_search: {
    word: ARGV[0]
  }
}.to_json

Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(request)
end
