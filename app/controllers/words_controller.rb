# frozen_string_literal: true

class WordsController < ApplicationController
  def index
    @words = Word.includes(:word_searches).order(created_at: :desc).page(params[:page])
  end

  def show
    @word = Word.find(params[:id])
  end
end
