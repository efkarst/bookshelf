class BookShelf < ApplicationRecord
  belongs_to :book 
  # has_many :user_books, through: :books
  belongs_to :shelf

  def self.remove_book_shelf_association(shelf_id, book_id)
    where("shelf_id=#{shelf_id}").where("book_id=#{book_id}").first.destroy
  end
end
