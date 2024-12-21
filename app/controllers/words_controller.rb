# frozen_string_literal: true

class WordsController < BaseController
  def index
    word_ids = current_user.word_searches.select('word_id as id').group(:word_id)
    @words = Word.where(id: word_ids).includes(%i[explanation
                                                  word_searches]).order(created_at: :desc).page(params[:page])

    @word_search = WordSearch.new
  end

  def show
    @word = Word.find(params[:id])
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy!
    redirect_to words_path
  end
end
