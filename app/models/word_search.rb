# frozen_string_literal: true

# == Schema Information
#
# Table name: word_searches
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  word_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_word_searches_on_user_id  (user_id)
#  index_word_searches_on_word_id  (word_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (word_id => words.id)
#
class WordSearch < ApplicationRecord
  belongs_to :word
end
