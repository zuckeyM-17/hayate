# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books, id: :uuid do |t|
      t.string :title, null: false, index: { unique: true }
      t.integer :category, null: false, default: 0

      t.timestamps
    end

    create_table :chapters, id: :uuid do |t|
      t.references :book, null: false, foreign_key: true, type: :uuid
      t.string :title, null: false
      t.integer :number, null: false

      t.timestamps
    end

    create_table :readings do |t|
      t.references :chapter, null: false, foreign_key: true, type: :uuid
      t.datetime :done_at, null: true

      t.timestamps
    end
  end
end
