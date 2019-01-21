class BooksController < ApplicationController
  # Require login before all actions
  before_action :require_login

  ### List books from all users
  def index
    # Filter book index based on a filter param
    if params[:filter]
      @books = Book.send(params[:filter].keys.first)
    
    # List all books by title
    else
      @books = Book.order_by_title 
    end
  end

  ### Show search results when user searches for a new book by title, with option for user to add books to their collection
  def new
    # Instantiate book instances from Google Books search results (by title)
    @books = BookFinder.search_google_books_by_title(params[:search])

    # Flash an error if Google does not return any books
    if @books.empty?
      flash[:alert] = "We can't find '#{params[:search]}' - please try again."
      redirect_to user_path(current_user)
    end
  end

  ### Show details of a specific book from search before the user decides to commit it to their collection
  def search_show
    # Instantiate book instance from Google Books search (by Google identifier)
    @book = BookFinder.search_google_books_by_identifier(params[:identifier])
  end

  ### Find or create books user chooses to add to their collection
  def create
    # Find or create a book instance based on Google identifier
    @book = Book.where(identifier: params[:book][:identifier]).first_or_create(book_params)

    # Redirect to user show page 
    redirect_to user_path(current_user)
  end

  ### Show details of a specific book in any users collection
  def show
    # Find Book instance from id in params
    @book = Book.find(params[:id])

    # Find UserBook instance associated with current user and book to display the current user's book activity
    @userbook = UserBook.find_by(user_id: current_user.id, book_id: @book.id) 
  end

  ### 
  def update
    raise params.inspect
    @book = Book.find(params[:id])
    @book.update(book_params)

    redirect_to user_path(current_user)
  end

  def destroy
    @book = Book.find(params[:id])
    @userbook = UserBook.where("user_id=#{current_user.id}").where("book_id=#{@book.id}").first

    @userbook.destroy
    @book.remove_book_from_current_user_shelves(book, current_user)
    @book.destroy if @book.users.empty?

    redirect_to user_path(current_user)
  end


  private

  def book_params(*args)
    params.require(:book).permit(:title, :pages, :description, :cover_image, :identifier, :genre_name, :author_name, :user_id, shelves_attributes: [:name, :user_id], user_shelf_ids: [])
  end
  
end
