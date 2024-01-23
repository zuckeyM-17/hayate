# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_tasks
#
#  id                 :bigint           not null, primary key
#  daily_task_item_id :bigint           not null
#  date               :date             not null
#  done               :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_daily_tasks_on_daily_task_item_id  (daily_task_item_id)
#
# Foreign Keys
#
#  fk_rails_...  (daily_task_item_id => daily_task_items.id)
#
class DailyTask < ApplicationRecord
  belongs_to :daily_task_items
end
