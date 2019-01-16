class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:home, :new, :create]

  def home
    if logged_in?
      redirect_to user_path(current_user)
    else
      render layout: 'welcome'
    end
  end

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else      
      @user = User.new
      render layout: 'welcome'
    end  
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new', layout: 'welcome'
    end

  end

  def show
    redirect_to root_path if !logged_in?
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
