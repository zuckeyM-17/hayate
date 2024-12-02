# frozen_string_literal: true

class RecreateTasks < ActiveRecord::Migration[8.0]
  def up
    drop_table :tasks

    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :category, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.datetime :done_at

      t.timestamps
    end
  end

  def down
    drop_table :tasks

    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: true
      t.integer :priority, null: false, default: 0
      t.integer :category, null: false, default: 0

      t.datetime :due_at, null: true
      t.datetime :done_at, null: true

      t.timestamps
    end
  end
end
