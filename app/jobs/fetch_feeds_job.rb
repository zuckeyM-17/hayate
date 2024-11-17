# frozen_string_literal: true

# 1時間ごとに全ユーザーのフィードを元に新しいEntryを取得するジョブ
class FetchFeedsJob < ApplicationJob
  queue_as :background

  def perform
    users = User.all

    users.each do |user|
      user.feeds.find_each(batch_size: 10) do |feed|
        FetchEntriesJob.perform_later(feed.id)
      end
    end
  end
end
