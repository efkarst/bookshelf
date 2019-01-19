class Shelf < ApplicationRecord
  has_many :book_shelves
  has_many :books, through: :book_shelves
  # has_many :user_books, through: :books

  belongs_to :user
  has_many :user_books, through: :user

  validates :name, presence: true
  validates_with MyValidator

end
