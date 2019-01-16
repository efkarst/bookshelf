class ReviewsController < ApplicationController
  before_action :require_login

  def new
    @book = Book.find(params[:book_id])
  end

  def create
    # r = Review.create(rating: 5, review: "HP!", user_book: ub)
  end
end
