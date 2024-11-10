# frozen_string_literal: true

class FetchEntriesJob < ApplicationJob
  queue_as :background
  retry_on StandardError, wait: 5.minutes, attempts: 3

  def perform(feed_id)
    feed = Feed.find(feed_id)
    latest_entry = feed.entries.order(published_at: :desc).first
    entries = if latest_entry.present?
                FeedEntryFetcher.new(feed).fetch!(from: latest_entry.published_at)
              else
                FeedEntryFetcher.new(feed).fetch!
              end
    ApplicationRecord.transaction do
      entries.each(&:save!)
      feed.update!(fetched_at: Time.zone.now)
    end
  end
end
