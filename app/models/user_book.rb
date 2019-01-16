class UserBook < ApplicationRecord
  belongs_to :user 
  belongs_to :book
  belongs_to :review, optional: true

  validates :review, presence: false

  def self.remove_user_book_association(user_id, book_id)
    UserBook.where("user_id=#{user_id}").where("book_id=#{book_id}").first.destroy
  end
end
