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

  def user_shelf_ids=(user_shelf_ids)
    user_shelf_ids.delete("")
    if user_shelf_ids.any?
      user = Shelf.find(user_shelf_ids.first).user
      remove_book_from_user_shelves(self,user)
      user_shelf_ids.each do |shelf_id|
          shelf = Shelf.find(shelf_id)
          self.shelves << shelf if !self.shelves.include?(shelf)
          self.save
      end
      user.destroy_empty_shelves
    end
  end

  def remove_book_from_user_shelves(book,user)
    user.shelves.each do |shelf|
      shelf.book_shelves.where("book_id=#{book.id}").destroy_all
    end
  end

  def user_shelf_ids
    self.shelves.collect { |shelf| shelf.id }
  end

  def shelves_attributes=(shelf_attributes)
    shelf_attributes.values.each do |shelf_attribute|
      if !shelf_attribute[:name].blank?
        shelf = Shelf.find_or_create_by(shelf_attribute)
        self.shelves << shelf
        self.save
      end
    end
  end

  ### Ratings ###
  def average_rating
    ratings = self.reviews.collect { |review| review.rating }
    ratings.inject{ |sum, el| sum + el }.to_f / ratings.size
  end

end


