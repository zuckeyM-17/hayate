# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.build(book_params.slice(:title, :category))
    book_params[:chapters].split(/\R/).each.with_index do |title, i|
      next if title.blank?
      book.chapters.build(title:, number: i).save!
    end
    if book.save
      redirect_to book_path(book.id), notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :category, :chapters)
  end
end
