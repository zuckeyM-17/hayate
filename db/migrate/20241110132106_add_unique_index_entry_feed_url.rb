# frozen_string_literal: true

class AddUniqueIndexEntryFeedUrl < ActiveRecord::Migration[8.0]
  def change
    add_index :entries, :url, unique: true
    add_index :feeds, :url, unique: true
  end
end
