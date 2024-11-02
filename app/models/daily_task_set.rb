# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_task_sets
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_daily_task_sets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class DailyTaskSet < ApplicationRecord
  has_many :daily_tasks, dependent: :destroy

  scope :this_week, -> { where(date: Time.zone.today.all_week) }
  scope :last_week, -> { where(date: Time.zone.today.last_week.all_week) }

  def self.init!(date: Time.zone.today)
    daily_task_set = find_or_initialize_by(date:)
    return nil if daily_task_set.persisted?

    daily_task_set.user = current_user
    daily_task_set.save!
    DailyTaskItem.enabled.each do |item|
      DailyTask.create!(daily_task_set:, daily_task_item: item)
    end
    daily_task_set
  end
end
