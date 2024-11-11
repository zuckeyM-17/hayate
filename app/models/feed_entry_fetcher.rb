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
    from.present? ? entries.select { |e| e.published_at > from } : entries.first(5)
  end

  private

  # rubocop:disable Metrics/AbcSize
  def atom_to_entries
    @rss.entries.map do |entry|
      Entry.new({
                  feed_id: @feed.id,
                  title: entry.title.content,
                  url: entry.link.href,
                  published_at: entry.published.content,
                  description: html_to_description(entry.content&.content || entry.summary.content),
                  thumbnail_url: get_thumbnail_url(entry.link.href)
                })
    end
  end

  def rss_to_entries
    @rss.items.map do |item|
      Entry.new({
                  feed_id: @feed.id,
                  title: item.title,
                  url: item.link,
                  published_at: item.pubDate,
                  description: html_to_description(item.description || item.content_encoded),
                  thumbnail_url: get_thumbnail_url(item.link)
                })
    end
  end
  # rubocop:enable Metrics/AbcSize

  def html_to_description(html)
    BaseController.helpers.strip_tags(html).truncate(200)
  end

  def get_thumbnail_url(url)
    doc = ::Nokogiri::HTML(OpenURI.open_uri(url).read)
    doc.css('meta[property="og:image"]').first&.[]('content')
  end
end
