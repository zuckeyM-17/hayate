# frozen_string_literal: true

class FetchEntriesJob < ApplicationJob
  queue_as :background
  retry_on StandardError, wait: 5.minutes, attempts: 3

  def perform(feed_id)
    feed = Feed.find(feed_id)
    latest_entry = feed.entries.order(published_at: :desc).first
    fetcher = FeedEntryFetcher.new(feed)
    if latest_entry.present?
      fetcher.fetch!(from: latest_entry.published_at)
    else
      fetcher.fetch!
    end
    ApplicationRecord.transaction do
      feed.update!(fetched_at: Time.zone.now)
    end
  end
end
