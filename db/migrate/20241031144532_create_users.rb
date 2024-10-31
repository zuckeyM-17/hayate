# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, &:timestamps
    create_table :user_profiles do |t|
      t.string :display_name, null: false

      t.timestamps
    end
  end
end
