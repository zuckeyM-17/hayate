# frozen_string_literal: true

class CreateCompletedTasks < ActiveRecord::Migration[8.0]
  def up
    change_table :scheduled_tasks, bulk: true do |t|
      t.date :date
    end
    remove_columns :scheduled_tasks, :done_at

    create_table :completed_tasks do |t|
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    change_table :scheduled_tasks, bulk: true do |t|
      t.datetime :done_at, :datetime, default: nil
    end
    remove_columns :scheduled_tasks, :date

    drop_table :completed_tasks
  end
end
