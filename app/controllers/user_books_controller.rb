class UserBooksController < ApplicationController

  def update
    
    if params[:user_book]["finish_date(1i)"]
      date_blank = params[:user_book]["finish_date(1i)"] == "" || params[:user_book]["finish_date(2i)"] == "" || params[:user_book]["finish_date(3i)"] == ""
      if date_blank == true
        finish_date = nil
      else
        finish_date = Date.new(params[:user_book]["finish_date(1i)"].to_i, params[:user_book]["finish_date(2i)"].to_i, params[:user_book]["finish_date(3i)"].to_i)
      end
    end
    @user_book = UserBook.find(params[:id])
    @user_book.update(user_book_params)
    @user_book.update(finish_date: finish_date)

    @book = Book.find(params[:book_id])
    redirect_to book_path(@book) 
  end

  private

  def user_book_params(*args)
    params.require(:user_book).permit(:finished_book, :shelf_name, shelf_ids: [])
  end
end
