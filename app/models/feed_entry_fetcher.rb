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
    items.map { |item| to_entry(item) }
  end

  private

  def to_entry(item)
    @feed.entries.find_or_initialize_by(url: item[:link]).tap do |entry|
      entry.assign_attributes(
        title: item[:title],
        published_at: item[:date],
        description: item[:content],
        thumbnail_url: get_thumbnail_url(item[:link])
      )
    end
  end

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

    def start_element(name, attrs = [])
      @current_element = name
      @current_item[:link] = attrs.to_h['href'] if name == 'link' && attrs.to_h['href'].present?
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
        @current_item[:title] = @current_item[:title].join
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

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize
    def element_value(string)
      case @current_element
      when 'title'
        @current_item[:title] ||= []
        @current_item[:title] << string.strip
      when 'link', 'id'
        url = string.strip
        @current_item[:link] = url if URI::DEFAULT_PARSER.make_regexp.match(url).present? && url.start_with?('http')
      when 'description', 'content', 'summary', 'content:encoded'
        @current_item[:content] ||= []
        @current_item[:content] << string.strip
      when 'pubDate', 'updated'
        @current_item[:date] = string.strip
      when 'lastBuildDate'
        @last_updated = string.strip
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize
  end
end
