class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books
  has_many :reviews, through: :user_books
  has_many :book_shelves
  has_many :shelves, through: :book_shelves
  belongs_to :genre
  belongs_to :author

  scope :find_by_identifier, ->(identifier) { where(identifier: identifier) }
  scope :order_by_title, -> { order(title: :asc)}
  scope :order_by_author, -> { joins(:author).merge(Author.order(name: :asc))}

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

  def shelf_names=(shelf_names)
    shelf_names.each do |shelf_name|
      if !shelf_name.blank?
        shelf = Shelf.find_by(name: shelf_name) 
        self.shelves << shelf if !self.shelves.include?(shelf)
      end
    end
  end

  def shelf_names
    self.shelves.collect do |shelf|
      shelf.name
    end
  end

  def shelves_attributes=(shelf_attributes)
    shelf_attributes.values.each do |shelf_attribute|
      if !shelf_attribute[:name].blank?
        shelf = Shelf.find_or_create_by(shelf_attribute)
        self.shelves << shelf
      end
    end
  end

end


