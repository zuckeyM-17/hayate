# frozen_string_literal: true

module Api
  class WordSearchesController < Api::BaseController
    protect_from_forgery

    def create
      authenticate!
      word = Word.find_or_initialize_by(en: word_search_params[:word].downcase)

      word.save!
      word.word_searches.create!(user: current_user)
      ExplainWordJob.perform_later(word.id)

      render json: { word: { id: word.id }, word_search: { id: word.word_searches.last.id } }
    end

    private

    def word_search_params
      params.expect(word_search: [:word])
    end
  end
end
