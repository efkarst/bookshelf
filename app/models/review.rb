class Review < ApplicationRecord
  has_one :user_book
  has_one :book, through: :user_book
  has_one :user, through: :user_book

  validates :title, presence: true
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, less_than: 6, greater_than: 0 }
  validates :review, presence: true

  def user_book_id=(id)
    self.user_book = UserBook.find(id)
  end
end
