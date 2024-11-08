# frozen_string_literal: true

# == Schema Information
#
# Table name: link_notes
#
#  id         :integer          not null, primary key
#  link_id    :integer          not null
#  note_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_link_notes_on_link_id  (link_id)
#  index_link_notes_on_note_id  (note_id)
#

class LinkNote < ApplicationRecord
end
