# frozen_string_literal: true

class AddFetchedAtToFeeds < ActiveRecord::Migration[8.0]
  def change
    add_column :feeds, :fetched_at, :datetime, null: true
  end
end
