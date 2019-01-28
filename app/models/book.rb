class Book < ApplicationRecord
  ### Associations ###
  has_many :user_books
  has_many :users, through: :user_books
  has_many :reviews, through: :user_books
  has_many :book_shelves
  has_many :shelves, through: :book_shelves
  belongs_to :genre
  belongs_to :author

  ### Scope Methods ###
  scope :find_by_identifier, ->(identifier) { where(identifier: identifier) }
  scope :order_by_author, -> { joins(:author).merge(Author.order(name: :asc))}
  scope :order_by_title, -> { order(title: :asc)}
  scope :top_rated, -> { joins(:user_books, :reviews).merge(Review.where("rating > 3")).uniq }

  def self.top_read
    UserBook.top_read_books.collect { |userbook| userbook.book }
  end

  ### Building and Updating Associations ###
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

  ### Ratings ###
  def average_rating
    ratings = self.reviews.collect { |review| review.rating }
    ratings.inject{ |sum, el| sum + el }.to_f / ratings.size
  end

end


