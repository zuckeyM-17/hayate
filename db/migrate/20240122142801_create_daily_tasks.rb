# frozen_string_literal: true

class CreateDailyTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_task_items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.datetime :disabled_at, null: true

      t.timestamps
    end

    create_table :daily_task_sets do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false

      t.timestamps
    end

    create_table :daily_tasks do |t|
      t.references :daily_task_set, null: false, foreign_key: true
      t.references :daily_task_item, null: false, foreign_key: true
      t.boolean :done, null: false, default: false

      t.timestamps
    end
  end
end
