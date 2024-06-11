# frozen_string_literal: true

require 'net/http'

module Sizume
  class Posts
    Post = Struct.new(:slug, :title, :bodyCharacterCount, :visibility, :createdAt, :updatedAt, :tags,
                      keyword_init: true)

    def initialize
      @api_key = Rails.application.credentials[:sizume][:api_key]
      @uri = URI.parse('https://sizu.me/api/v1/posts')
      @req_options = { use_ssl: @uri.scheme == 'https' }
    end

    def call(created_after: nil)
      @uri.query = URI.encode_www_form({ createdAfter: created_after }) if created_after
      request = Net::HTTP::Get.new(@uri)
      request['Authorization'] = "Bearer #{@api_key}"
      res = Net::HTTP.start(@uri.host, @uri.port, @req_options) { |http| http.request request }
      JSON.parse(res.body).symbolize_keys[:posts].map do |post|
        Post.new(post)
      end
    end
  end
end
