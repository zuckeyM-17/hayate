# frozen_string_literal: true

class FeedEntryFetcher
  attr_reader :rss

  def initialize(feed)
    @feed = feed
    @rss = FeedEntryFetcher::Document.new
  end

  def fetch!(from: nil)
    parse!
    items = from.present? ? @rss.items.select { |i| i[:date] > from } : @rss.items.first(5)
    items.map do |item|
      Entry.new({
                  feed_id: @feed.id,
                  title: item[:title],
                  url: item[:link],
                  published_at: item[:date],
                  description: item[:content],
                  thumbnail_url: get_thumbnail_url(item[:link])
                })
    end
  end

  private

  def parse!
    Nokogiri::XML::SAX::Parser.new(@rss).parse(OpenURI.open_uri(@feed.url).read)
  end

  def get_thumbnail_url(url)
    doc = ::Nokogiri::HTML(OpenURI.open_uri(url).read)
    doc.css('meta[property="og:image"]').first&.[]('content')
  end

  class Document < Nokogiri::XML::SAX::Document
    attr_accessor :items

    def initialize
      @items = []
      @current_item = {}
      @current_element = nil
      super
    end

    def start_element(name, _attrs = [])
      @current_element = name
      return unless %w[item entry].include?(name)

      @current_item = {}
    end

    def end_element(name)
      if %w[item entry].include?(name)
        @current_item[:content] = BaseController.helpers.strip_tags(@current_item[:content].join).truncate(200)
        @items << @current_item
        @current_item = {}
      end
      @current_element = nil
    end

    def characters(string)
      element_value(string)
    end

    def cdata_block(string)
      element_value(string)
    end

    def element_value(string)
      case @current_element
      when 'title'
        @current_item[:title] = string.strip
      when 'link'
        @current_item[:link] = string.strip
      when 'description', 'content'
        @current_item[:content] ||= []
        @current_item[:content] << string.strip
      when 'pubDate', 'updated'
        @current_item[:date] = string.strip
      end
    end
  end
end
