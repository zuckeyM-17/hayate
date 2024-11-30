# frozen_string_literal: true

class CreateUserCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :user_credentials do |t|
      t.references :user, null: false, foreign_key: true
      t.string :display_name, null: false, index: { unique: true }
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
