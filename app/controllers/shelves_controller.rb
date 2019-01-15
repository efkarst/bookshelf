class ShelvesController < ApplicationController
  before_action :require_login

  def new
    @shelf = Shelf.new
  end

  def create
    @shelf = Shelf.new(shelf_params)
    if @shelf.save
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def show
    @shelf = Shelf.find(params[:id])
  end
  
  def edit
    @shelf = Shelf.find(params[:id])
    redirect_to user_shelf_path(@shelf.user,@shelf) if current_user != @shelf.user
  end

  def update
    @shelf = Shelf.find(params[:id])
    if @shelf.update(shelf_params)
      redirect_to user_shelf_path(current_user,@shelf)
    else
      render 'edit'
    end
  end

  def destroy
    @shelf = Shelf.find(params[:id])
    if current_user == @shelf.user
      @shelf.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_shelf_path(@shelf.user,@shelf)
    end
  end

  private

  def shelf_params
    params.require(:shelf).permit(:name, :user_id, book_ids:[])
  end
end
