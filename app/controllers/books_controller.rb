# require 'httparty'

class BooksController < ApplicationController

  def index
    @books = Book.all 
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @books = BookFinder.search_google_books_by_title(params[:search])
  end

  def create
    @book = Book.create(book_params)
    current_user.books << @book
    current_user.save

    redirect_to user_path(current_user)

  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :description, :cover_image, :isbn, :genre_name, :author_name, :user)
  end
end
