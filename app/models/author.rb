class Author < ApplicationRecord
  ### Associations ###
  has_many :books
  has_many :genres, through: :books
end
