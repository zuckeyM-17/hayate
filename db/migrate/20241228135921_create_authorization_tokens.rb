# frozen_string_literal: true

class CreateAuthorizationTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :authorization_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :token, null: false, index: { unique: true }
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
