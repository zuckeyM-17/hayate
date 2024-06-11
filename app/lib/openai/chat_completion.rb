# frozen_string_literal: true

require 'net/http'

module Openai
  class ChatCompletion
    def initialize
      @open_ai_api_key = Rails.application.credentials[:openai][:api_key]
      @uri = URI.parse('https://api.openai.com/v1/chat/completions')
      @req_options = { use_ssl: @uri.scheme == 'https' }
    end

    def call(messages)
      request = Net::HTTP::Post.new(@uri)
      request.content_type = 'application/json'
      request['Authorization'] = "Bearer #{@open_ai_api_key}"
      request.body = { model: 'gpt-4', messages: }.to_json

      Net::HTTP.start(@uri.hostname, @uri.port, @req_options) do |http|
        res = http.request(request)
        JSON.parse(res.body)['choices'][0]['message']['content']
      end
    end
  end
end
