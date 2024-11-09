# frozen_string_literal: true

# == Schema Information
#
# Table name: entries
#
#  id            :integer          not null, primary key
#  feed_id       :integer          not null
#  title         :string           not null
#  url           :string           not null
#  description   :text
#  thumbnail_url :string
#  published_at  :datetime         not null
#  read_at       :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_entries_on_feed_id  (feed_id)
#

class Entry < ApplicationRecord
  belongs_to :feed

  validates :title, presence: true
  validates :url, presence: true
  validates :published_at, presence: true
  validates :description, length: { maximum: 200 }

  scope :unread, -> { where(read_at: nil) }

  def read!
    update!(read_at: Time.zone.now)
  end
end
