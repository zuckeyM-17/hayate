# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false, index: { unique: true }
      t.integer :category, null: false, default: 0
      t.datetime :finished_at, null: true

      t.timestamps
    end

    create_table :chapters do |t|
      t.references :book, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :number, null: false

      t.timestamps
    end

    create_table :readings do |t|
      t.references :chapter, null: false, foreign_key: true
      t.datetime :done_at, null: true

      t.timestamps
    end
  end
end
