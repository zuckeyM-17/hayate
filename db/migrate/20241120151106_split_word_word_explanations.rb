# frozen_string_literal: true

class SplitWordWordExplanations < ActiveRecord::Migration[8.0]
  def up
    create_table :word_explanations do |t|
      t.references :word, null: false, foreign_key: true
      t.string :ja, null: false
      t.string :meaning, null: false
      t.string :phonetic_symbols, null: false
      t.json :misc, null: false

      t.timestamps
    end

    change_table :words, bulk: true do |_t|
      remove_column :words, :ja, :string
      remove_column :words, :pronunciation_symbol, :string
      remove_column :words, :meaning, :string
      remove_column :words, :misc, :json
    end
  end

  def down
    change_table :words, bulk: true do |_t|
      add_column :words, :ja, :string, null: false, default: ''
      add_column :words, :pronunciation_symbol, :string, null: false, default: ''
      add_column :words, :meaning, :string, null: false, default: ''
      add_column :words, :misc, :json, null: false, default: {}
    end

    drop_table :word_explanations
  end
end
