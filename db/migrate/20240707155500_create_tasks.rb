# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.integer :priority, null: false, default: 0
      t.integer :category, null: false, default: 0

      t.datetime :due_at, null: true
      t.datetime :done_at, null: true

      t.timestamps
    end

    create_table :recurring_tasks do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.integer :priority, null: false, default: 0
      t.integer :category, null: false, default: 0

      t.integer :weekday, null: false

      t.timestamps
    end
  end
end
