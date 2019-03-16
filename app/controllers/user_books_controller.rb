class UserBooksController < ApplicationController
  ### Update userbook with activity from user for a book
  def update
    @user_book = UserBook.find(params[:id]) # Find user_book
    @user_book.update(finish_date: finish_date) if params[:user_book]["finish_date(1i)"] # Update book finish date if recieved
    @user_book.update(user_book_params)     # Update user_book with strong params
    @user_book.update(user_book_params(:shelf_name)) if user_book_params(:shelf_name)

    @book = @user_book.book                 # Find book
    redirect_to book_path(@book)            # Redirect to book show page
  end

  ### Define finish date from user DateTime input
  def finish_date
    date_blank = params[:user_book]["finish_date(1i)"] == "" || params[:user_book]["finish_date(2i)"] == "" || params[:user_book]["finish_date(3i)"] == ""
    
    if date_blank == true   # if the user input a blank or incomplete date, set finish_date to nil
      finish_date = nil
    else                    # else set finish_date to the date they entered
      finish_date = Date.new(params[:user_book]["finish_date(1i)"].to_i, params[:user_book]["finish_date(2i)"].to_i, params[:user_book]["finish_date(3i)"].to_i)
    end
  end

  private
  
  def user_book_params(*args)
    params.require(:user_book).permit(:finished_book, :shelf_name, shelf_ids: [])
  end
end
