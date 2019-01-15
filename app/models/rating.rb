class Rating < ApplicationRecord
  belongs_to :user_book
  belongs_to :book, through: :user_book
  belongs_to :user, through: :user_book
end
