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
url = 'API_URL' # Your API URL

uri = URI.parse("#{url}/word_searches")
request = Net::HTTP::Post.new(uri)
request.content_type = 'application/json'
request['Authorization'] = "Bearer #{authorization_token}"

request.body = {
  word_search: {
    word: ARGV[0]
  }
}.to_json

word_id = nil
Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  res = http.request(request)

  if res.code != '200'
    puts "Error: #{res.code}"
    exit
  end
  word_id = JSON.parse(res.body)['word']['id']
end

ja_word = nil

uri = URI.parse("#{url}/words/#{word_id}")
request = Net::HTTP::Get.new(uri)
request.content_type = 'application/json'
request['Authorization'] = "Bearer #{authorization_token}"

while(ja_word.nil?)
  sleep 2
  Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    res = http.request(request)

    if res.code != '200'
      puts "Error: #{res.code}"
      exit
    end
    ja_word = JSON.parse(res.body)['word']['ja']
  end
end

puts "#{ARGV[0]}: #{ja_word}. Saved!!"
