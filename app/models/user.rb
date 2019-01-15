class User < ApplicationRecord
  has_many :user_books
  has_many :books, through: :user_books
  has_many :ratings, through: :user_books
  has_many :shelves
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def add_shelf(shelf_name)
    self.shelves.create(name: shelf_name)
  end

  def firstname
    self.name.split(' ')[0]
  end
end
