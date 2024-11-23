# frozen_string_literal: true

class ExplainWordJob < ApplicationJob
  queue_as :default

  def perform(word_id)
    word = Word.find(word_id)
    Word::Explain.new(word).call! if word.explanation.blank?
  end
end
