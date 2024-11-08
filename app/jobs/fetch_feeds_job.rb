# frozen_string_literal: true

# 10分に一度前ユーザーのフィードを元に新しいEntryを取得するジョブ
class FetchFeedsJob < ApplicationJob
  queue_as :background
  retry_on StandardError, wait: 5.minutes, attempts: 3

  def perform
    users = User.all

    users.each do |user|
      user.feeds.each do |feed|
        FetchEntriesJob.perform_later(feed.id) if FeedEntryFetcher.new(feed).last_updated_at > 10.minutes.ago
      end
    end
  end
end
