class Genre < ApplicationRecord
  ### Associations ###
  has_many :books
  has_many :authors, through: :books
end
