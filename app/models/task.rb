# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  title       :string           not null
#  description :text
#  category    :integer          default("other"), not null
#  start_date  :date             not null
#  end_date    :date             not null
#  done_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
  has_many :task_notes, dependent: :destroy
  has_many :notes, through: :task_notes
  has_one :scheduled_task, dependent: :destroy
  has_one :completed_task, dependent: :destroy

  enum :category, { other: 0, work: 10, skill: 20, personal: 30, housework: 40 }

  validates :title, :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  scope :other, -> { where(category: :other) }
  scope :work, -> { where(category: :work) }
  scope :skill, -> { where(category: :skill) }
  scope :personal, -> { where(category: :personal) }
  scope :housework, -> { where(category: :housework) }

  scope :today, -> { where(start_date: ..Time.zone.now).where(end_date: Time.zone.now..) }
  scope :this_week, -> { where(start_date: Time.zone.now.all_week) }
  scope :todo, -> { where.missing(:completed_task) }
  scope :done, -> { where.not(completed_task: nil) }

  def done?
    done_at.present?
  end

  def done!
    update!(done_at: Time.zone.now)
  end

  def schedule_for_today!
    ScheduledTask.create!(user: user, task: self, date: Time.zone.now.to_date)
  end

  def complete!
    ActiveRecord::Base.transaction do
      scheduled_task.destroy!
      CompletedTask.create!(task: self)
    end
  end

  private

  def end_date_after_start_date
    return unless end_date.present? && start_date.present? && end_date < start_date

    errors.add(:end_date, 'は開始日より後の日付でなければなりません')
  end
end
