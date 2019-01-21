class ApplicationController < ActionController::Base
  helper_method :logged_in?
  helper_method :current_user

  # True if user logged in, false if not
  def logged_in?
    !!session[:user_id]
  end

  # Instance of user currentlg logged in
  def current_user
    user ||= User.find(session[:user_id])
  end

  # Redirect to root path if user not logged in
  def require_login
    redirect_to root_path if !logged_in?
  end

  # 
  # def current_user_book_activity(book)
  #   UserBook.where("user_id = #{current_user.id}").where("book_id = #{book.id}").first
  # end
end
