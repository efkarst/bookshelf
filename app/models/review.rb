class Review < ApplicationRecord
  belongs_to :user_books
  has_one :book, through: :user_books
  has_one :user, through: :user_books
end
