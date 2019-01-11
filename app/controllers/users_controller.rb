class UsersController < ApplicationController

  def home
    redirect_to user_path(current_user) if logged_in?
    render layout: 'welcome'
  end

  def new
    redirect_to user_path(current_user) if logged_in?
    @user = User.new
    render layout: 'welcome'
    
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
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
