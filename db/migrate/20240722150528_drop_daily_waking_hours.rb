# frozen_string_literal: true

class DropDailyWakingHours < ActiveRecord::Migration[7.1]
  def change
    drop_table :daily_waking_hours do |t|
      t.references :daily_task_set, null: false, foreign_key: true
      t.datetime :upped_at, null: true, default: nil
      t.datetime :turned_in_at, null: true, default: nil

      t.timestamps
    end
  end
end
