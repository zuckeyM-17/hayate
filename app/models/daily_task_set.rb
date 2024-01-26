# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_task_sets
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DailyTaskSet < ApplicationRecord
  has_many :daily_tasks, dependent: :destroy
end
