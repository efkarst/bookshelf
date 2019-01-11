class User < ApplicationRecord
  has_many :user_books
  has_many :books, through: :user_books
  has_many :shelves
  has_secure_password

  def add_shelf(shelf_name)
    self.shelves.create(name: shelf_name)
  end
end
