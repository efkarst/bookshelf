class UserBooksController < ApplicationController
  ### Update userbook with activity from user for a book
  def update
    @user_book = UserBook.find(params[:id]) # Find user_book
    @user_book.update(user_book_params)     # Update user_book with strong params
    @user_book.update(user_book_params(:shelf_name)) #Update with shelf_name after shelf_ids to ensure shelf_name isn't overriden

    @book = @user_book.book                 # Find book
    redirect_to book_path(@book)            # Redirect to book show page
  end

  private
  
  def user_book_params(*args)
    params.require(:user_book).permit(:finished_book, :date_finished, :shelf_name, shelf_ids: [])
  end
end
