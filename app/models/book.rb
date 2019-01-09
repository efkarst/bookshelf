class Book < ApplicationRecord
  has_many :user_books
  has_many :book_shelves
  has_many :users, through: :user_books
  has_many :shelves, through: :book_shelves
  belongs_to :genre
  belongs_to :author
end
