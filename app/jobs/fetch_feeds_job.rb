# frozen_string_literal: true

# 10分に一度前ユーザーのフィードを元に新しいEntryを取得するジョブ
class FetchFeedsJob < ApplicationJob
  queue_as :default

  def perform
    users = User.all

    users.each do |user|
      user.feeds.each do |feed|
        FetchEntriesJob.perform_later(feed.id)
      end
    end
  end
end
