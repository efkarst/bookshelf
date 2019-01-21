class UserBook < ApplicationRecord
  ### Associations ###
  belongs_to :user 
  belongs_to :book
  belongs_to :review, optional: true

  ### Validations ###
  validates :review, presence: false

end
