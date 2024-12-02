# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_tasks
#
#  id                 :bigint           not null, primary key
#  daily_task_set_id  :bigint           not null
#  daily_task_item_id :bigint           not null
#  done               :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_daily_tasks_on_daily_task_item_id  (daily_task_item_id)
#  index_daily_tasks_on_daily_task_set_id   (daily_task_set_id)
#
# Foreign Keys
#
#  fk_rails_...  (daily_task_item_id => daily_task_items.id)
#  fk_rails_...  (daily_task_set_id => daily_task_sets.id)
#
class DailyTask < ApplicationRecord
  belongs_to :daily_task_set
  belongs_to :daily_task_item
end
