module ReviewsHelper

  # Return the id of the user book a review is associated with
  def user_book_id(book_id, user_id)
    UserBook.find_user_book_activity(user_id, book_id).id
  end

  # Returns current users review of provided book
  def current_users_book_review(book)
    UserBook.where("user_id = #{current_user.id}").where("book_id = #{book.id}").first.review
  end

end
