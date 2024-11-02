# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  category    :integer          default("other"), not null
#  finished_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_books_on_title  (title) UNIQUE
#
class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :readings, through: :chapters

  scope :unread, -> { where(finished_at: nil) }
  scope :finished, -> { where.not(finished_at: nil) }

  enum :category, { engineering: 10, management: 20, english: 30, other: 0 }

  def in_progress?
    readings.in_progress.present?
  end

  def start!
    Reading.create!(chapter: chapters.min_by(&:number))
  end

  def next!
    reading = readings.in_progress.first
    reading.done!
    Reading.create!(chapter: chapters.find_by(number: reading.chapter.number + 1))
  end

  def finish!
    reading = readings.in_progress.first
    reading.done!
    update!(finished_at: Time.zone.now)
  end

  def finish?
    finished_at.present?
  end
end
