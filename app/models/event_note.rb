# frozen_string_literal: true

# == Schema Information
#
# Table name: event_notes
#
#  id         :bigint           not null, primary key
#  event_id   :bigint           not null
#  note_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_event_notes_on_event_id  (event_id)
#  index_event_notes_on_note_id   (note_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (note_id => notes.id)
#

class EventNote < ApplicationRecord
end
