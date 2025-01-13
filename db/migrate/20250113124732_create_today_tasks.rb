# frozen_string_literal: true

class CreateTodayTasks < ActiveRecord::Migration[8.0]
  def up
    create_table :today_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.datetime :done_at

      t.timestamps
    end

    remove_columns :tasks, :rescheduled_at
  end

  def down
    drop_table :today_tasks

    change_table :tasks, bulk: true do |t|
      t.datetime :rescheduled_at, :datetime, default: nil
    end
  end
end
