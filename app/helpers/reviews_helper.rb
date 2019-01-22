module ReviewsHelper

  # Return the id of the user book a review is associated with
  def user_book_id(book_id, user_id)
    UserBook.where("user_id = #{user_id}").where("book_id = #{book_id}").first.id
  end

  def current_user_has_reviewed?(book)
    # binding.pry
    res = false
    book.reviews.each do |review|
      res = true if review.user == current_user
    end
    res
  end


  def current_users_book_review(book)
    UserBook.where("user_id = #{current_user.id}").where("book_id = #{book.id}").first.review
  end
end
