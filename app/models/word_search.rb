# frozen_string_literal: true

# == Schema Information
#
# Table name: word_searches
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  word_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_word_searches_on_user_id  (user_id)
#  index_word_searches_on_word_id  (word_id)
#

class WordSearch < ApplicationRecord
  belongs_to :word
  belongs_to :user
end
