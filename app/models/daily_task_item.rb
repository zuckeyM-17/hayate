# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_task_items
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  disabled_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class DailyTaskItem < ApplicationRecord
  has_many :daily_tasks, dependent: :destroy

  scope :enabled, -> { where(disabled_at: nil) }

  def disable!
    update!(disabled_at: Time.zone.now)
  end
end
