# == Schema Information
#
# Table name: word_explanations
#
#  id         :bigint           not null, primary key
#  word_id    :bigint           not null
#  ja         :string           not null
#  meaning    :string           not null
#  misc       :json             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_word_explanations_on_word_id  (word_id)
#
# Foreign Keys
#
#  fk_rails_...  (word_id => words.id)
#

# frozen_string_literal: true

class WordExplanation < ApplicationRecord
  belongs_to :word

  validates :ja, presence: true
  validates :meaning, presence: true
  validates :misc, presence: true
end
