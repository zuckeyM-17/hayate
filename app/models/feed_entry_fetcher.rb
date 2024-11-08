# frozen_string_literal: true

class FeedEntryFetcher
  attr_reader :rss

  def initialize(feed)
    @feed = feed
    @rss = RSS::Parser.parse(OpenURI.open_uri(@feed.url).read)
  end

  def fetch!(from: nil)
    entries = case @rss
              in RSS::Atom::Feed
                atom_to_entries
              in RSS::Rss
                rss_to_entries
              else
                raise 'Unsupported feed type'
              end
    from.nil? ? entries.first(5) : entries.select { |e| e.published_at > from }
  end

  def last_updated_at
    case @rss
    in RSS::Atom::Feed
      @rss.updated.content
    in RSS::Rss
      @rss.channel.lastBuildDate || @rss.updated.content
    else
      raise 'Unsupported feed type'
    end
  end

  private

  # rubocop:disable Metrics/AbcSize
  def atom_to_entries
    @rss.entries.map do |entry|
      @feed.entries.build({
                            title: entry.title.content,
                            url: entry.link.href,
                            published_at: entry.published.content,
                            description: html_to_description(entry.content&.content || entry.summary.content),
                            thumbnail_url: get_thumbnail_url(entry.link.href)
                          })
    end
  end
  # rubocop:enable Metrics/AbcSize

  def rss_to_entries
    @rss.items.map do |item|
      @feed.entries.build({
                            title: item.title,
                            url: item.link,
                            published_at: item.pubDate,
                            description: html_to_description(item.description),
                            thumbnail_url: get_thumbnail_url(item.link)
                          })
    end
  end

  def html_to_description(html)
    ApplicationController.helpers.strip_tags(html).truncate(200)
  end

  def get_thumbnail_url(url)
    doc = ::Nokogiri::HTML(OpenURI.open_uri(url).read)
    doc.css('meta[property="og:image"]').first&.[]('content')
  end
end