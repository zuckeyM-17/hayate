# frozen_string_literal: true

# == Schema Information
#
# Table name: reading_notes
#
#  id         :integer          not null, primary key
#  reading_id :integer          not null
#  note_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reading_notes_on_note_id     (note_id)
#  index_reading_notes_on_reading_id  (reading_id)
#

class ReadingNote < ApplicationRecord
  belongs_to :reading
  belongs_to :note
end
