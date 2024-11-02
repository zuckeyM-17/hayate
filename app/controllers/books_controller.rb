# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    books = current_user.books
    @unread_books = books.unread.page(params[:page])
    @finished_books = books.finished.page(params[:page])
  end

  def show
    @book = current_user.books.find(params[:id])
  end

  def new
    @book = Book.new(user: current_user)
  end

  def create
    book = Book.register!(user: current_user, title: book_params[:title], category: book_params[:category],
                          chapters: book_params[:chapters])
    redirect_to book_path(book.id), notice: 'Book was successfully created.'
  end

  def start
    book = current_user.books.find(params[:id])
    book.start!
    redirect_to reading_path(book.readings.first), notice: 'Reading was successfully created.'
  end

  def next
    book = current_user.books.find(params[:id])
    book.next!
    redirect_to reading_path(book.readings.in_progress.first), notice: 'Next reading was successfully created.'
  end

  def finish
    book = current_user.books.find(params[:id])
    book.finish!
    redirect_to book_path(book), notice: 'Reading was successfully finished.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :category, :chapters)
  end
end
