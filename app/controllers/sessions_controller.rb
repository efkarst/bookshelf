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
    elsif request.env["omniauth.auth"]
      user_info = request.env["omniauth.auth"]

      @user = User.find_or_create_by(uid: user_info["uid"]) do |u|
        u.name      = user_info["info"]["name"]
        u.email     = user_info["info"]["email"]
        u.image_url = user_info["info"]["image"]
        u.password = "none"
      end

      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      if !@user
        flash[:alert] = "We don't have an account associated with that email." 
      else
        flash[:alert] = "Your password is incorrect - please try again." 
      end
      redirect_to signin_path
    end

  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
