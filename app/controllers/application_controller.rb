class ApplicationController < ActionController::Base
  helper_method :logged_in?
  helper_method :current_user

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    user ||= User.find(session[:user_id])
  end

  def require_login
    redirect_to root_path if !logged_in?
  end
end
