class Shelf < ApplicationRecord
  ### Associations ###
  has_many :book_shelves
  has_many :books, through: :book_shelves
  belongs_to :user
  has_many :user_books, through: :user

  ### Validations ###
  validates :name, presence: true
  validates_with MyValidator

end
