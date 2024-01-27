# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_task_sets
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DailyTaskSet < ApplicationRecord
  has_many :daily_tasks, dependent: :destroy

  scope :this_week, -> { where(date: Time.zone.today.all_week) }

  def self.init!
    daily_task_set = create!(date: Time.zone.today)
    DailyTaskItem.enabled.each do |item|
      DailyTask.create!(daily_task_set:, daily_task_item: item)
    end
    daily_task_set
  end
end
