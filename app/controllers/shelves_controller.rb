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

  private

  def shelf_params
    params.require(:shelf).permit(:name, :user_id, book_ids:[])
  end
end
