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
      @feed.entries.find_or_initialize_by(url: item[:link]).tap do |entry|
        entry.title = item[:title]
        entry.published_at = item[:date]
        entry.description = item[:content]
        entry.thumbnail_url = get_thumbnail_url(item[:link])
      end
    end
  end

  private

  def parse!
    return if @rss.items.present?

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
      @last_updated = nil
      super
    end

    def start_element(name, _attrs = [])
      @current_element = name
      return unless %w[item entry].include?(name)

      @current_item = {}
    end

    def end_element(name)
      if %w[item entry].include?(name)
        @current_item[:content] = if @current_item[:content].present?
                                    BaseController.helpers.strip_tags(@current_item[:content].join).truncate(200)
                                  else
                                    ''
                                  end
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
      when 'link', 'id'
        @current_item[:link] = string.strip
      when 'description', 'content', 'summary', 'content:encoded'
        @current_item[:content] ||= []
        @current_item[:content] << string.strip
      when 'pubDate', 'updated'
        @current_item[:date] = string.strip
      when 'lastBuildDate'
        @last_updated = string.strip
      end
    end
  end
end
