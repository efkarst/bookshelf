class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books
  has_many :book_shelves
  has_many :shelves, through: :book_shelves
  belongs_to :genre
  belongs_to :author

  def author_name=(author_name)
    self.author = Author.find_or_create_by(name: author_name)
  end

  def genre_name=(genre_name)
    self.genre = Genre.find_or_create_by(name: genre_name)
  end
end
