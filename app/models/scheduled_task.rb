# frozen_string_literal: true

# == Schema Information
#
# Table name: scheduled_tasks
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  task_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  date       :date
#
# Indexes
#
#  index_scheduled_tasks_on_task_id  (task_id)
#  index_scheduled_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
class ScheduledTask < ApplicationRecord
  belongs_to :user
  belongs_to :task

  scope :today_or_past, -> { where(date: ..Time.zone.now.to_date) }

  def reschedule_for_tommorow!
    update(date: Time.zone.tomorrow)
  end
end
