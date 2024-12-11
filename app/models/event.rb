# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  title       :string           not null
#  description :text
#  category    :integer          default("other"), not null
#  date        :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Event < ApplicationRecord
  belongs_to :user
  has_many :event_notes, dependent: :destroy
  has_many :notes, through: :event_notes

  enum :category, { other: 0, work: 10, skill: 20, personal: 30, housework: 40 }
  validates :title, :date, presence: true

  scope :other, -> { where(category: :other) }
  scope :work, -> { where(category: :work) }
  scope :skill, -> { where(category: :skill) }
  scope :personal, -> { where(category: :personal) }
  scope :housework, -> { where(category: :housework) }

  scope :today, lambda {
    now = Time.zone.now
    where(date: now.beginning_of_day..).where(date: ..now.end_of_day)
  }

  scope :by_date, ->(date) { where(date: date) }

  scope :by_month, lambda { |month|
    where(date: month.all_month)
  }

  scope :future, lambda {
    from = Month.future.first.all_month.first
    to = Month.future.last.all_month.last
    where(date: from..to)
  }

  def save_with_note!
    ApplicationRecord.transaction do
      save!
      Note.create!(user: user, body: to_note_body) if today?
    end
  end

  def today?
    date == Time.zone.today
  end

  def to_note_body
    <<~BODY
      # Event: #{title} #{ApplicationController.helpers.task_category(category)}
      #{description}
    BODY
  end
end
