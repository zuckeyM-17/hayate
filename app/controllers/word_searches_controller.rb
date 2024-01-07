# frozen_string_literal: true

class WordSearchesController < ApplicationController
  def index
    @word_searches = WordSearch.select(:word_id).distinct
  end

  def show
    @word_search = WordSearch.find(params[:id])
  end

  def new
    @word_search = WordSearch.new
  end

  def create
    word = Word.find_by(en: word_search_params[:word])

    if word.nil?
      word = Word::Explain.new(word_search_params[:word]).call
      word.save!
    end
    @word_search = word.word_searches.create!

    redirect_to word_search_path(@word_search.id), notice: 'WordSearch was successfully created.'
  end

  private

  def word_search_params
    params.require(:word_search).permit(:word)
  end
end
