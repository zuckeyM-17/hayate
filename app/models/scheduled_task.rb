# frozen_string_literal: true

# == Schema Information
#
# Table name: scheduled_tasks
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

  scope :today, -> { where(created_at: Time.zone.now.all_day) }

  def done!
    ActiveRecord::Base.transaction do
      update(done_at: Time.zone.now)
      task.done!
      Note.new(user:, body: <<~BODY)
        #{ApplicationController.helpers.task_category(task.category)} [#{task.title}](#{task_path(task)}) Done
      BODY
    end
  end
end
