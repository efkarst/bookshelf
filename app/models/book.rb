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

  def user_id=(user_id)
    self.users << User.find(user_id)
    self.save
  end

  def self.find_by_identifier(identifier)
    self.where(identifier: identifier)
  end

  def self.unsorted
    # self.joins(:book_shelves).where.not(book_shelves: {id:}).uniq & joins(:boats, :boat_classifications, :classifications).where(classifications: {name: "Sailboat"}).uniq
    unsorted = []
    Book.all.each do |book|
      unsorted << book if book.shelves.empty?
    end
    unsorted
  end
end


