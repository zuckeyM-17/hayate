# frozen_string_literal: true

class FeedResolver
  def initialize(url)
    @url = url
  end

  def resolve
    link = resolve_feed_link!(@url)
    Feed.new(title: link[:title], url: link[:url])
  end

  private

  def resolve_feed_link!(url)
    uri = URI.parse(url)
    link_h = feed_url_and_title(uri.to_s)
    link_h = feed_url_and_title("#{uri.scheme}://#{uri.hostname}/") if link_h.blank?
    link_h
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def feed_url_and_title(uri)
    doc = ::Nokogiri::HTML(OpenURI.open_uri(uri).read)
    link = doc.css('link[type*="application/rss+xml"]').first || doc.css('link[type*="application/atom+xml"]').first
    title = doc.css('title')&.first&.text || doc.css('meta[property="og:title"]')&.first&.attr('content')
    return nil if link.blank?

    href = URI.parse(link[:href])
    {
      url: href.scheme.present? ? href.to_s : URI.join(uri, href.to_s).to_s,
      title: title || link[:title]
    }
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end
