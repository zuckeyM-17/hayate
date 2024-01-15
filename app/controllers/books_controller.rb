# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page])
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.build(book_params.slice(:title, :category))
    book_params[:chapters].split(/\R/).each.with_index(1) do |title, i|
      next if title.blank?

      book.chapters.build(title:, number: i)
    end
    if book.save
      redirect_to book_path(book.id), notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def start
    book = Book.find(params[:id])
    book.start!
    redirect_to reading_path(book.readings.first), notice: 'Reading was successfully created.'
  end

  def next
    book = Book.find(params[:id])
    book.next!
    redirect_to reading_path(book.readings.in_progress.first), notice: 'Next reading was successfully created.'
  end

  def finish
    book = Book.find(params[:id])
    book.finish!
    redirect_to book_path(book), notice: 'Reading was successfully finished.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :category, :chapters)
  end
end
