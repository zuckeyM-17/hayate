# frozen_string_literal: true

# == Schema Information
#
# Table name: recurring_tasks
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text
#  priority    :integer          default("new_added"), not null
#  category    :integer          default("other"), not null
#  weekday     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class RecurringTask < ApplicationRecord
  include Taskable

  flag :weekday, %i[sunday monday tuesday wednesday thursday friday saturday]
end
