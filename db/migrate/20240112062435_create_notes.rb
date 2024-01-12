# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.text :body, null: false

      t.timestamps
    end

    create_table :chapter_notes do |t|
      t.references :chapter, null: false, foreign_key: true, type: :uuid
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
