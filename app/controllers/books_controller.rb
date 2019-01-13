# require 'httparty'

class BooksController < ApplicationController

  def index
    @books = Book.all 
  end

  def show
    @book = Book.find(params[:id])
  end

  def search_show
    @book = BookFinder.search_google_books_by_identifier(params[:identifier])
  end

  def new
    @books = BookFinder.search_google_books_by_title(params[:search])
  end

  def create
    @book = Book.where(identifier: params[:book][:identifier]).first_or_create(book_params)
    current_user.books << @book
    current_user.save

    redirect_to user_path(current_user)

  end

  private

  def book_params(*args)
    params.require(:book).permit(:title, :pages, :description, :cover_image, :identifier, :genre_name, :author_name, :user)
  end
  
end
