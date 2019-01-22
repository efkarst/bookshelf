class BooksController < ApplicationController
  before_action :require_login   # Require login before all actions

  ### List books from all users
  def index
    if params[:filter]
      @books = Book.send(params[:filter].keys.first)    # Filter book index based on a filter param
    else
      @books = Book.order_by_title                      # List all books by title
    end
  end

  ### Show search results when user searches for a new book by title, with option for user to add books to their collection
  def new
    @books = BookFinder.search_google_books_by_title(params[:search])             # Instantiate book instances from Google Books search results (by title)
    if @books.empty?                                                              # Flash an error if Google does not return any books and redirect to user path
      flash[:alert] = "We can't find '#{params[:search]}' - please try again."    
      redirect_to user_path(current_user)
    end
  end

  ### Show details of a specific book from search before the user decides to commit it to their collection
  def search_show
    @book = BookFinder.search_google_books_by_identifier(params[:identifier])     # Instantiate book instance from Google Books search (by Google identifier)
  end

  ### Find or create books user chooses to add to their collection
  def create
    @book = Book.where(identifier: params[:book][:identifier]).first_or_create(book_params)  # Find or create a book instance based on Google identifier
    redirect_to user_path(current_user)                                                      # Redirect to user show page 
  end

  ### Show details of a specific book in any users collection
  def show
    @book = Book.find(params[:id])                                            # Find Book instance from id in params
    @userbook = UserBook.find_by(user_id: current_user.id, book_id: @book.id) # Find UserBook instance associated with current user and book to display the current user's book activity
  end

  ### Update book attributes
  def update
    @book = Book.find(params[:id]).update(book_params)  # Find book and update with book_params
    redirect_to user_path(current_user)                 # Redirect to User Show page
  end

  ### Remove book from current user's collection
  def destroy
    @book = Book.find(params[:id])                           # Find current book and userbook associated with current book and user 
    @userbook = UserBook.find_by(user_id: current_user.id, book_id: @book.id)
    @userbook.remove_book_from_shelves(@book,current_user)   # Remove book from current user's shelves    
    @userbook.destroy                                        # Destroy user's association with the book
    @book.destroy if @book.users.empty?                      # Destroy book if it is no longer associated with any users
    redirect_to user_path(current_user)                      # Redirect to User show page
  end


  private

  def book_params(*args)
    params.require(:book).permit(:title, :pages, :description, :cover_image, :identifier, :genre_name, :author_name, :user_id)
  end
  
end
