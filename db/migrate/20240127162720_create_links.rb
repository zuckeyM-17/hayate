# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.datetime :read_at

      t.timestamps
    end

    create_table :link_notes do |t|
      t.references :link, null: false, foreign_key: true
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end

    create_table :favorite_links do |t|
      t.references :link, null: false, foreign_key: true
      t.datetime :archived_at, null: true

      t.timestamps
    end
  end
end
