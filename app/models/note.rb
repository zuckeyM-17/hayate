# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Note < ApplicationRecord
  has_one :chapter_note, dependent: :destroy
  has_one :chapter, through: :chapter_note
end
