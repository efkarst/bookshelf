class Review < ApplicationRecord
  has_one :user_book
  has_one :book, through: :user_book
  has_one :user, through: :user_book
end
