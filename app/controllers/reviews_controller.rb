class ReviewsController < ApplicationController
  before_action :require_login

  def new
    @book = Book.find(params[:book_id])
  end
end
