# frozen_string_literal: true

class FetchEntriesJob < ApplicationJob
  queue_as :background

  def perform(feed_id)
    feed = Feed.find(feed_id)
    latest_entry = feed.entries.order(published_at: :desc).first
    entries = FeedEntryFetcher.new(feed).fetch!(from: latest_entry&.published_at)
    entries.each(&:save!)
    feed.update!(fetched_at: Time.zone.now)
  end
end
