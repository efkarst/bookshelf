class UsersController < ApplicationController
  before_action :require_login  # Require login except with home, new or create action
  skip_before_action :require_login, only: [:home, :new, :create]

  ### Home page with sign in and sign up for users that are not logged in
  def home
    if logged_in?
      redirect_to user_path(current_user)   # Redirect to user show page if logged in
    else
      render layout: 'welcome'              # Render home view with welcome layout
    end
  end

  ### Render sign up form
  def new
    if logged_in?
      redirect_to user_path(current_user)   # Redirect to user show page if logged in
    else      
      @user = User.new                      # Stub a new user
      render layout: 'welcome'              # Render sign up form with welcome layout
    end  
  end

  ### Create a new user from info in sign up form
  def create
    @user = User.new(user_params)     # Instantiate a new user

    if @user.save                     # If user saves log them in by adding their id to the session hash
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new', layout: 'welcome' # If user does not save re-render sign up form with errors
    end

  end

  ### Render user show page
  def show
    @user = User.find(params[:id])  # Find user's page to render
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
