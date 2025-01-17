# frozen_string_literal: true

# == Schema Information
#
# Table name: completed_tasks
#
#  id         :bigint           not null, primary key
#  task_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_completed_tasks_on_task_id  (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#
class CompletedTask < ApplicationRecord
  belongs_to :task
end
