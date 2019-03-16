class UserBook < ApplicationRecord
  ### Associations ###
  belongs_to :user 
  belongs_to :book
  belongs_to :review, optional: true

  ### Validations ###
  validates :review, presence: false

  ### Scope Methods ###
  scope :find_user_book_activity, ->(user_id, book_id) { where("user_id = #{user_id}").where("book_id = #{book_id}").first }
  scope :top_read_books, -> {where("finished_book=true").group(:book_id).order("count(book_id) desc")}

  ### Building, Updating and Finding Associations ###
  def shelf_ids=(shelf_ids)
    book.shelf_ids = shelf_ids
    user.destroy_empty_shelves
  end

  def shelf_ids
    shelves.collect { |shelf| shelf.id }
  end

  def shelf_name=(shelf_name)
    if shelf_name != ""
      shelf = self.user.shelves.find_or_create_by(name: shelf_name)
      shelf.books << self.book
    end
  end

  def shelf_name
  end

  def shelves
    self.user.shelves & self.book.shelves
  end

  def remove_book_from_shelves(book,user)
    shelves.each do |shelf|
      shelf.book_shelves.where("book_id=#{book.id}").each do |bookshelf|
        bookshelf.destroy  #if (Time.now.utc - shelf.created_at.utc > 2)
      end
    end
  end

end
