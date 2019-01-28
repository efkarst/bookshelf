class ReviewsController < ApplicationController
  before_action :require_login  # Require login before all actions
  before_action :valid_book, only: [:new, :show, :edit]
  before_action :valid_review, only: [:show, :edit]

  ### Render new review form
  def new
    @book = Book.find(params[:book_id])
    redirect_to user_path(current_user) if !current_user.has_book?(@book)
    @review = Review.new()
  end

  ### Create new review for current user based on new form input
  def create
    @review = Review.new(review_params)    # Instantiate review
    
    if @review.save
      redirect_to book_path(@review.book)  # Redirect to book path if review saves
    else
      @book = Book.find(params[:book_id])  # Show errors on new review page if the review does not save
      render 'new'
    end

  end

  ### Render edit form for a review
  def edit
    @book = Book.find(params[:book_id]) # Find book
    @review = Review.find(params[:id])  # Find review
    
    redirect_to book_path(@book) if @review.user != current_user #Redirect user to book show page if they did not create the review
  end

  ### Update review based on edit form input
  def update
    @book = Book.find(params[:book_id]) # Find book
    @review = Review.find(params[:id])  # Find review

    if @review.update(review_params)
      redirect_to book_path(@book)      # Redirect to book path if review saves
    else
      render 'edit'                     # Show errors on edit review page if the review does not save
    end

  end

  ### Delete a review (if it belongs to current user)
  def destroy
    @book = Book.find(params[:book_id])               # Find book
    @review = Review.find(params[:id])                # Find review
    
    @review.destroy if @review.user == current_user   # Destroy the review if it belongs to the current user
    
    redirect_to book_path(@book)                      # Redirect to book show page
  end

  private
  def review_params
    params.require(:review).permit(:title, :rating, :review, :user_book_id)
  end
end
