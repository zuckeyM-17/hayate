# frozen_string_literal: true

# == Schema Information
#
# Table name: readings
#
#  id         :bigint           not null, primary key
#  chapter_id :uuid             not null
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

  scope :in_progress, -> { where(done_at: nil) }

  def done!
    update!(done_at: Time.zone.now)
  end
end
