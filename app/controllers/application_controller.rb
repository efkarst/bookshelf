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

  # Ensure id in route represents a valid user
  def valid_user
    if params[:user_id] && !User.exists?(params[:user_id])
      redirect_to user_path(current_user)
    elsif params[:user_id]
    elsif !params[:user_id] && !User.exists?(params[:id])
      redirect_to user_path(current_user)
    end
  end

  # Ensure id in route represents a valid book
  def valid_book
    if params[:book_id] && !Book.exists?(params[:book_id])
      redirect_to user_path(current_user)
    elsif params[:book_id]
    elsif !params[:book_id] && !Book.exists?(params[:id])
      redirect_to user_path(current_user)
    end
  end

  # Ensure id in route respresents a valid shelf
  def valid_shelf
    redirect_to user_path(current_user) if !Shelf.exists?(params[:id])
  end

  # Ensure id in route respresents a valid review
  def valid_review
    redirect_to user_path(current_user) if !Review.exists?(params[:id])
  end

end
