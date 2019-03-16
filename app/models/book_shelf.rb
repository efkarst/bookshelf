class BookShelf < ApplicationRecord
  ### Associations ###
  belongs_to :book 
  belongs_to :shelf

end
