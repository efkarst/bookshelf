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
    clear_user_shelves(@book.id)
    @book.update(book_params)
    clear_empty_shelves
    redirect_to user_path(current_user)
  end

  def create
    @book = Book.where(identifier: params[:book][:identifier]).first_or_create(book_params)
    redirect_to user_path(current_user)
  end

  def destroy
    @book = Book.find(params[:id])
    remove_associations(@book.id)
    @book.destroy if @book.users.empty?
    clear_empty_shelves
    redirect_to user_path(current_user)
  end


  def remove_associations(book_id)
    UserBook.remove_user_book_association(current_user.id, book_id)
    clear_user_shelves(book_id)
  end

  def clear_user_shelves(book_id)
    current_user.shelves.each do |shelf|
      shelf.book_shelves.where("book_id=#{book_id}").destroy_all
    end
  end

  def clear_empty_shelves
    current_user.shelves.each do |shelf|
      shelf.destroy if shelf.books.empty?
    end
  end

  private

  def book_params(*args)
    params.require(:book).permit(:title, :pages, :description, :cover_image, :identifier, :genre_name, :author_name, :user_id, shelves_attributes: [:name, :user_id], user_shelf_names: [])
  end
  
end
