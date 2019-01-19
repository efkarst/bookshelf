class UserBook < ApplicationRecord
  belongs_to :user 
  # has_many :shelves, through: :user

  belongs_to :book
  # has_many :book_shelves, through: :book
  # has_many :shelves, through: :book_shelves

  belongs_to :review, optional: true

  validates :review, presence: false

  def self.remove_user_book_association(user_id, book_id)
    self.where("user_id=#{user_id}").where("book_id=#{book_id}").first.destroy
  end
end
