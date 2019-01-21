class BookShelf < ApplicationRecord
  ### Associations ###
  belongs_to :book 
  belongs_to :shelf

  ### Updating Associations ###
  def self.remove_book_shelf_association(shelf_id, book_id)
    where("shelf_id=#{shelf_id}").where("book_id=#{book_id}").first.destroy
  end
end
