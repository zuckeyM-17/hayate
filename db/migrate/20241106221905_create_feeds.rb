# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[8.0]
  def change
    create_table :feeds do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end

    create_table :entries do |t|
      t.references :feed, null: false, foreign_key: true
      t.string :title, null: false
      t.string :url, null: false
      t.text :description, null: true
      t.string :thumbnail_url, null: true
      t.datetime :published_at, null: false
      t.datetime :read_at, null: true

      t.timestamps
    end
  end
end
