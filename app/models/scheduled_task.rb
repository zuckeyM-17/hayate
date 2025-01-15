# frozen_string_literal: true

# == Schema Information
#
# Table name: today_tasks
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  task_id    :bigint           not null
#  done_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_today_tasks_on_task_id  (task_id)
#  index_today_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
class ScheduledTask < ApplicationRecord
  belongs_to :user
  belongs_to :task

  scope :today, -> { where(created_at: Time.zone.now.all_day) }

  def done!
    ActiveRecord::Base.transaction do
      update(done_at: Time.zone.now)
      task.done!
    end
  end
end
