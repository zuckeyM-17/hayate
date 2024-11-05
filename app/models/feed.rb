# frozen_string_literal: true

class Feed
  attr_accessor :title, :url

  def self.create_from_url!(url)
    doc = ::Nokogiri::HTML(OpenURI.open_uri(url).read)
    link = doc.css('link').to_a.filter { |l| l[:type] == 'application/rss+xml' }.first
    Feed.new(
      url: link[:href].start_with?('http') ? link[:href] : URI.join(url, link[:href]).to_s,
      title: link[:title]
    )
  end

  def initialize(title: nil, url: nil)
    @title = title
    @url = url
  end
end
