# == Schema Information
#
# Table name: chapter_notes
#
#  id         :bigint           not null, primary key
#  chapter_id :uuid             not null
#  note_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chapter_notes_on_chapter_id  (chapter_id)
#  index_chapter_notes_on_note_id     (note_id)
#
# Foreign Keys
#
#  fk_rails_...  (chapter_id => chapters.id)
#  fk_rails_...  (note_id => notes.id)
#
class ChapterNote < ApplicationRecord
  belongs_to :chapter
  belongs_to :note
end
