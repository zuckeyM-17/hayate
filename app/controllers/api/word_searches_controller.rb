# frozen_string_literal: true

module Api
  class WordSearchesController < Api::BaseController
    protect_from_forgery

    def create
      authenticate!
      word = Word.find_or_initialize_by(en: word_search_params[:word])

      word.save!
      word.word_searches.create!(user: current_user)
      ExplainWordJob.perform_later(word.id)
      head :created
    end

    private

    def word_search_params
      params.require(:word_search).permit(:word)
    end
  end
end
