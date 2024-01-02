# frozen_string_literal: true

# == Schema Information
#
# Table name: words
#
#  id                   :uuid             not null, primary key
#  en                   :string           not null
#  ja                   :string           not null
#  pronunciation_symbol :string           not null
#  meaning              :string           not null
#  misc                 :json             not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_words_on_en  (en) UNIQUE
#
class Word < ApplicationRecord
end
