# require 'httparty'

class BooksController < ApplicationController
  before_action :require_login

  def index
    if params[:filter]
      @books = Book.send(params[:filter].keys.first)
    else
      @books = Book.order_by_title 
    end
  end

  def show
    @book = Book.find(params[:id])
    @userbook = current_user_book_activity(@book)
  end

  def search_show
    @book = BookFinder.search_google_books_by_identifier(params[:identifier])
  end

  def new
    @books = BookFinder.search_google_books_by_title(params[:search])
    if @books.empty?
      flash[:alert] = "We can't find '#{params[:search]}' - please try again."
      redirect_to user_path(current_user)
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.users << current_user
    @book.save
    redirect_to user_path(current_user)
  end

  def update_status
    #need to figure out methods for book finding values in join tables
    
  end

  def create
    @book = Book.where(identifier: params[:book][:identifier]).first_or_create(book_params)
    redirect_to user_path(current_user)
  end

  def destroy
    @book = Book.find(params[:id])
    UserBook.remove_user_book_association(current_user.id, @book.id)
    @book.destroy if @book.users.empty?
    redirect_to user_path(current_user)
  end

  private

  def book_params(*args)
    params.require(:book).permit(:title, :pages, :description, :cover_image, :identifier, :genre_name, :author_name, :user_id)
  end
  
end
