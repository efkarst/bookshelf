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

  def read_status_for_current_user=(read_staus_for_current_user, current_user)
    self.user_books.where("user_id=#{current_user.id}").first.update(finished_book: read_staus_for_current_user)
  end

  def read_status_for_user(current_user)
    UserBook.where("user_id = #{current_user.id}").where("book_id = #{self.id}").first
    # t.integer "book_id"
    # t.boolean "finished_book", default: false
    # t.datetime "finish_date"
  end

end


