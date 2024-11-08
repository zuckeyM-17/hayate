# frozen_string_literal: true

class FeedEntryFetcher
  def initialize(feed)
    @feed = feed
  end

  def fetch!(from: nil)
    @rss ||= RSS::Parser.parse(OpenURI.open_uri(@feed.url).read)
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

  private

  def atom_to_entries
    @rss.entries.map do |entry|
      @feed.entries.build({
                            title: entry.title.content,
                            url: entry.link.href,
                            published_at: entry.published.content,
                            description: html_to_description(entry.content.content),
                            thumbnail_url: get_thumbnail_url(entry.link.href)
                          })
    end
  end

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
