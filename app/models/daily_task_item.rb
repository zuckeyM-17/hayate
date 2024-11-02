# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_task_items
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  name        :string           not null
#  disabled_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_daily_task_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class DailyTaskItem < ApplicationRecord
  has_many :daily_tasks, dependent: :destroy

  scope :enabled, -> { where(disabled_at: nil) }

  def disable!
    update!(disabled_at: Time.zone.now)
  end
end
