# frozen_string_literal: true

# == Schema Information
#
# Table name: readings
#
#  id         :bigint           not null, primary key
#  chapter_id :bigint           not null
#  done_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_readings_on_chapter_id  (chapter_id)
#
# Foreign Keys
#
#  fk_rails_...  (chapter_id => chapters.id)
#
class Reading < ApplicationRecord
  belongs_to :chapter

  has_many :reading_notes, dependent: :destroy
  has_many :notes, through: :reading_notes

  scope :in_progress, -> { where(done_at: nil) }

  def done!
    update!(done_at: Time.zone.now)
  end
end
