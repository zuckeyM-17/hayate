# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words, id: :uuid do |t|
      t.string :en, null: false, index: { unique: true }
      t.string :ja, null: false
      t.string :pronunciation_symbol, null: false
      t.string :meaning, null: false
      t.json :misc, null: false, default: {}

      t.integer :count, null: false, default: 0

      t.timestamps
    end
  end
end
