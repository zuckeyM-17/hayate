# frozen_string_literal: true

# == Schema Information
#
# Table name: weekly_objectives
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  start_date :date             not null
#  end_date   :date             not null
#  objective  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_weekly_objectives_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class WeeklyObjective < ApplicationRecord
  belongs_to :user
  has_one :weekly_review, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :objective, presence: true
  validate :end_date_is_after_start_date

  scope :by_user, ->(user) { where(user: user) }
  scope :current_week, lambda {
    today = Time.zone.today
    where('start_date <= ? AND end_date >= ?', today, today)
  }

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    return unless end_date < start_date

    errors.add(:end_date, 'must be after the start date')
  end
end
