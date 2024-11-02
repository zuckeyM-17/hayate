# frozen_string_literal: true

class WordsController < ApplicationController
  def index
    @words = current_user.words.order(created_at: :desc).page(params[:page])
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
