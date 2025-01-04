# frozen_string_literal: true

module Api
  class WordsController < Api::BaseController
    protect_from_forgery

    def show
      authenticate!
      word = Word.find_by(id: params[:id])

      if word.nil?
        render json: { errors: { title: 'Word(6) is not found' }, status: :not_found }
      elsif word.explanation.present?
        render json: WordResource.new(word).serialize
      else
        render json: { errors: { title: 'Word explanation generating...' }, status: :too_early }
      end
    end
  end
end
