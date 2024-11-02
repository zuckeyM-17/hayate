# frozen_string_literal: true

# == Schema Information
#
# Table name: words
#
#  id                   :bigint           not null, primary key
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
  has_many :word_searches, dependent: :destroy

  validates :en, presence: true, uniqueness: true
  validates :ja, presence: true
  validates :pronunciation_symbol, presence: true
  validates :meaning, presence: true
  validates :misc, presence: true

  class Explain
    SYSTEM_MESSAGE = <<~SYSTEM_MESSAGE
      Based on the English word entered by the user, output the "Japanese meaning", "English description", "thesaurus", "phonetic symbols", and "example sentences" in the following format (JSON).

      # Given word

      description

      # Output

      {
        "additional_info": "this is additional info",
        "ja": "記述、叙述、描写",
        "description": "a statement that represents something in words",
        "thesaurus": "account, characterization, chronicle, depiction, description, detail",
        "phonetic_symbols": "dɪskrípʃən",
        "examples": [
          "the description of the event was quite different from what had actually happened.",
          "The description of the book was accurate."
        ]
      }
    SYSTEM_MESSAGE

    def initialize(word)
      @word = Word.new(en: word)
    end

    def call!
      messages = [
        { role: 'system', content: SYSTEM_MESSAGE },
        { role: 'user', content: @word.en },
        { role: 'system', content: '{ "additional_info":' }
      ]
      res = JSON.parse(format('{ "additional_info": %s', ::Openai::ChatCompletion.new.call(messages)))

      @word.attributes = {
        ja: res['ja'],
        pronunciation_symbol: res['phonetic_symbols'],
        meaning: res['description'],
        misc: {
          thesaurus: res['thesaurus'],
          examples: res['examples']
        }
      }
      @word
    end
  end
end
