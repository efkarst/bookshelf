class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user) if logged_in?
    render layout: 'welcome'
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to signin_path
    end

  end

  def destroy
    session.clear
    redirect_to signin_path
  end

end
