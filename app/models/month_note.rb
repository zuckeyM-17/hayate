# frozen_string_literal: true

# == Schema Information
#
# Table name: month_notes
#
#  id         :bigint           not null, primary key
#  note_id    :bigint           not null
#  month_id   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_month_notes_on_month_id  (month_id)
#  index_month_notes_on_note_id   (note_id)
#
# Foreign Keys
#
#  fk_rails_...  (note_id => notes.id)
#

class MonthNote < ApplicationRecord
end
