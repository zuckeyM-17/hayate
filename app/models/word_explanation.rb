# == Schema Information
#
# Table name: word_explanations
#
#  id               :integer          not null, primary key
#  word_id          :integer          not null
#  ja               :string           not null
#  meaning          :string           not null
#  phonetic_symbols :string           not null
#  misc             :json             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_word_explanations_on_word_id  (word_id)
#

# frozen_string_literal: true

class WordExplanation < ApplicationRecord
  belongs_to :word

  validates :ja, presence: true
  validates :pronunciation_symbol, presence: true
  validates :meaning, presence: true
  validates :misc, presence: true
end
