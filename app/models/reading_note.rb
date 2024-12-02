# frozen_string_literal: true

# == Schema Information
#
# Table name: reading_notes
#
#  id         :bigint           not null, primary key
#  reading_id :bigint           not null
#  note_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reading_notes_on_note_id     (note_id)
#  index_reading_notes_on_reading_id  (reading_id)
#
# Foreign Keys
#
#  fk_rails_...  (note_id => notes.id)
#  fk_rails_...  (reading_id => readings.id)
#

class ReadingNote < ApplicationRecord
  belongs_to :reading
  belongs_to :note
end
