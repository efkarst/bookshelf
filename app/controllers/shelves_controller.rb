class ShelvesController < ApplicationController
  before_action :require_login
  
  ### Render form to create new shelf
  def new
    @shelf = Shelf.new  # Stub new shelf
  end

  # Create new shelf with data from new shelf form
  def create
    @shelf = Shelf.new(shelf_params)      # Instantiate a new shelf

    if @shelf.save
      redirect_to user_path(current_user) # If shelf saves redirect to user show page
    else
      render 'new'                        # If shelf doesn't save re-render new form with errors
    end
  end

  ### Render show view with details of shelf and its books
  def show
    @shelf = Shelf.find(params[:id])   # Find shelf
  end
  
  ### Render shelf edit form
  def edit
    @shelf = Shelf.find(params[:id])    # Find Shelf
    redirect_to user_shelf_path(@shelf.user,@shelf) if current_user != @shelf.user  # Redirect user to shelf show page if the shelf does not belong to them
  end

  ### Update shelf with data from edit form
  def update
    @shelf = Shelf.find(params[:id])                    # Find Shelf

    if @shelf.update(shelf_params)
      redirect_to user_shelf_path(current_user,@shelf)  # If shelf saves, redirect to shelf show page
    else
      render 'edit'                                     # If shelf doesn't save, re-render edit form with errors
    end

  end

  ### Destroy shelf if it belongs to current user
  def destroy
    @shelf = Shelf.find(params[:id])                   # Find Shelf

    if current_user == @shelf.user                     # If shelf belongs to user, destroy shelf and redirect to user show page
      @shelf.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_shelf_path(@shelf.user,@shelf)  # If shelf deosn't belong to user, redirect to shelf show path
    end

  end


  private

  def shelf_params
    params.require(:shelf).permit(:name, :user_id, book_ids:[])
  end
end
