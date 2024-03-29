# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words, id: :uuid do |t|
      t.string :en, null: false, index: { unique: true }
      t.string :ja, null: false
      t.string :pronunciation_symbol, null: false
      t.string :meaning, null: false
      t.json :misc, null: false, default: {}

      t.timestamps
    end

    create_table :word_searches do |t|
      t.references :word, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
