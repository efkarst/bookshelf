class ShelvesController < ApplicationController

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
  end

  def update
    @shelf = Shelf.find(params[:id])
    if @shelf.update(shelf_params)
      redirect_to user_shelf_path(current_user,@shelf)
    else
      render 'edit'
    end
  end

  private

  def shelf_params
    params.require(:shelf).permit(:name, :user_id, book_ids:[])
  end
end
