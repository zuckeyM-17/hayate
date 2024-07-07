# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text
#  priority    :integer          default("new_added"), not null
#  category    :integer          default("other"), not null
#  due_at      :datetime
#  done_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  include Taskable

  scope :todo, -> { where(done_at: nil) }
  scope :done, -> { where.not(done_at: nil) }

  def done?
    done_at.present?
  end

  def done!
    update(done_at: Time.zone.now)
  end
end
