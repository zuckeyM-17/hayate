# frozen_string_literal: true

class CreateTaskEventNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :task_notes do |t|
      t.references :task, null: false, foreign_key: true
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end

    create_table :event_notes do |t|
      t.references :event, null: false, foreign_key: true
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
