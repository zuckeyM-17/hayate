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
  has_one :daily_waking_hour, dependent: :destroy

  scope :this_week, -> { where(date: Time.zone.today.all_week) }
  scope :last_week, -> { where(date: Time.zone.today.last_week.all_week) }

  def self.init!(date: Time.zone.today)
    daily_task_set = find_or_initialize_by(date:)
    return nil if daily_task_set.persisted?

    daily_task_set.save!
    DailyTaskItem.enabled.each do |item|
      DailyTask.create!(daily_task_set:, daily_task_item: item)
    end
    DailyWakingHour.create!(daily_task_set:)
    daily_task_set
  end
end
