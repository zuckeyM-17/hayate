# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_waking_hours
#
#  id                :bigint           not null, primary key
#  daily_task_set_id :bigint           not null
#  upped_at          :datetime
#  turned_in_at      :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_daily_waking_hours_on_daily_task_set_id  (daily_task_set_id)
#
# Foreign Keys
#
#  fk_rails_...  (daily_task_set_id => daily_task_sets.id)
#
class DailyWakingHour < ApplicationRecord
  belongs_to :daily_task_set
end
