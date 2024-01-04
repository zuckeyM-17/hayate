# frozen_string_literal: true

class WordSearchesController < ApplicationController
  def show
    @word_search = WordSearch.find(params[:id])
  end

  def new
    @word_search = WordSearch.new
  end

  def create
    word = Word.find_or_initialize_by(en: word_search_params[:word])
    if word.new_record?
      word.assign_attributes({
                               ja: 'ほげ',
                               pronunciation_symbol: 'hoge',
                               meaning: 'hoge',
                               misc: { thesaurus: %w[hoge fuga piyo], examples: ['this is example.'] }
                             })
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
