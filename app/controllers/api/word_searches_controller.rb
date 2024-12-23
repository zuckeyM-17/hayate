# frozen_string_literal: true

module Api
  class WordSearchesController < ApplicationController
    protect_from_forgery

    def create
      word = Word.find_or_initialize_by(en: word_search_params[:word])

      word.save!
      word.word_searches.create!(user: User.first)
      ExplainWordJob.perform_later(word.id)
      head :created
    end

    private

    def word_search_params
      params.require(:word_search).permit(:word)
    end
  end
end
