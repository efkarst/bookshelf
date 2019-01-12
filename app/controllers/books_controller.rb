# require 'httparty'

class BooksController < ApplicationController

  def index
    @books = Book.all 
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @books = BookFinder.search_google_books(params[:search])
  end

  def create
  end

end
