# frozen_string_literal: true

class CreateMonthNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :month_notes do |t|
      t.references :note, null: false, foreign_key: true
      t.string :month_id, null: false

      t.timestamps
    end

    add_index :month_notes, :month_id
  end
end
