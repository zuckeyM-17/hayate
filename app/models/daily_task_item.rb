# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_task_items
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  num         :integer          not null
#  disabled_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class DailyTaskItem < ApplicationRecord
  has_many :daily_tasks, dependent: :destroy
end
