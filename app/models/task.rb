# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id             :bigint           not null, primary key
#  user_id        :bigint           not null
#  title          :string           not null
#  description    :text
#  category       :integer          default("other"), not null
#  start_date     :date             not null
#  end_date       :date             not null
#  done_at        :datetime
#  rescheduled_at :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord
  belongs_to :user

  enum :category, { other: 0, work: 10, skill: 20, personal: 30, housework: 40 }

  validates :title, :start_date, :end_date, presence: true

  scope :other, -> { where(category: :other) }
  scope :work, -> { where(category: :work) }
  scope :skill, -> { where(category: :skill) }
  scope :personal, -> { where(category: :personal) }
  scope :housework, -> { where(category: :housework) }

  scope :today, -> { where(start_date: ..Time.zone.now).where(end_date: Time.zone.now..) }
  scope :todo, -> { where(done_at: nil).where(rescheduled_at: nil) }
  scope :done, -> { where.not(done_at: nil) }

  def done?
    done_at.present?
  end

  def done!
    update(done_at: Time.zone.now)
  end
end
