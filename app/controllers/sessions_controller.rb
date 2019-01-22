class SessionsController < ApplicationController
  ### Render sign in form
  def new
    redirect_to user_path(current_user) if logged_in? # Redirect to user show page if logged in
    render layout: 'welcome'                          # User welcome layout
  end

  def create
    if request.env["omniauth.auth"]   # Create session from Google sign in if controller has access to their environment data
      create_from_google(request.env["omniauth.auth"])
    else
      create_from_bookshelf           # Create session from local Bookshelf signin
    end
  end

  ### Log user in using Google Oath2
  def create_from_google(user_info)
    @user = User.find_or_create_by(uid: user_info["uid"]) do |u|
      u.name      = user_info["info"]["name"]
      u.email     = user_info["info"]["email"]
      u.image_url = user_info["info"]["image"]
      u.password = "none"
    end                               # Find or create user from Google data

    session[:user_id] = @user.id      # Log user in by adding id to session hash
    redirect_to user_path(@user)      # redirect to user show page
  end

  ### Log user in with authenticated bookshelf credentials
  def create_from_bookshelf
    @user = User.find_by(email: params[:email])       # Find user by email

    if @user && @user.authenticate(params[:password]) # If user exists and is authenticated, log them in by adding their ID to the session hash
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    elsif !@user                                       # If user doesn't exists flash error on signin page
      flash[:alert] = "We don't have an account associated with that email." 
      redirect_to signin_path
    else                                               # If password is incorrect flash error on signin page
      flash[:alert] = "Your password is incorrect - please try again." 
      redirect_to signin_path
    end

  end

  ### End session by clearing the session hash and redirect user to home page
  def destroy
    session.clear
    redirect_to root_path
  end

end
