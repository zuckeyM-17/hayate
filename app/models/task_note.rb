# frozen_string_literal: true

# == Schema Information
#
# Table name: task_notes
#
#  id         :bigint           not null, primary key
#  task_id    :bigint           not null
#  note_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_task_notes_on_note_id  (note_id)
#  index_task_notes_on_task_id  (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (note_id => notes.id)
#  fk_rails_...  (task_id => tasks.id)
#

class TaskNote < ApplicationRecord
  belongs_to :task
  belongs_to :note
end
