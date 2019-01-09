class Shelf < ApplicationRecord
  has_many :book_shelves
  has_many :books, through: :book_shelves
  belongs_to :user
end
