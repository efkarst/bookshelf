class ReviewsController < ApplicationController
  before_action :require_login

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new()
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to book_path(@review.book)
    else
      @book = Book.find(params[:book_id])
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
  end

  def update
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    if @review.user == current_user
      @review.destroy
    end
    redirect_to book_path(@book)
  end

  private
  def review_params
    params.require(:review).permit(:title, :rating, :review, :user_book_id)
  end
end
