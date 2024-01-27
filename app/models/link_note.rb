# frozen_string_literal: true

# == Schema Information
#
# Table name: link_notes
#
#  id         :bigint           not null, primary key
#  link_id    :bigint           not null
#  note_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_link_notes_on_link_id  (link_id)
#  index_link_notes_on_note_id  (note_id)
#
# Foreign Keys
#
#  fk_rails_...  (link_id => links.id)
#  fk_rails_...  (note_id => notes.id)
#
class LinkNote < ApplicationRecord
end
