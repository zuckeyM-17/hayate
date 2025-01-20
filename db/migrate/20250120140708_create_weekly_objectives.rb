# frozen_string_literal: true

class CreateWeeklyObjectives < ActiveRecord::Migration[8.0]
  def change
    create_table :weekly_objectives do |t|
      t.references :user, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :objective, null: false

      t.timestamps
    end

    create_table :weekly_reviews do |t|
      t.references :weekly_objective, null: false, foreign_key: true
      t.text :review, null: false

      t.timestamps
    end
  end
end
