# frozen_string_literal: true

class DropColumnWordExplanationPhoneticSymbols < ActiveRecord::Migration[8.0]
  def up
    remove_column :word_explanations, :phonetic_symbols
  end

  def down
    add_column :word_explanations, :phonetic_symbols, :string, null: false, default: ''
  end
end
