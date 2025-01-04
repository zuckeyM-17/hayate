# frozen_string_literal: true

class WordSearchesController < BaseController
  def new
    @word_search = WordSearch.new(user: current_user)
  end

  def create
    word = Word.find_or_initialize_by(en: word_search_params[:word].downcase)

    if word.save
      word.word_searches.create!(user: current_user)
      ExplainWordJob.perform_later(word.id)
      redirect_to word_path(word), notice: 'WordSearch was successfully created.'
    else
      redirect_to new_word_search_path, alert: 'WordSearch was failed to create.'
    end
  end

  private

  def word_search_params
    params.require(:word_search).permit(:word)
  end
end
