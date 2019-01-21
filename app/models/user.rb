class User < ApplicationRecord
  ### Associations ###
  has_many :user_books
  has_many :books, through: :user_books
  has_many :reviews, through: :user_books
  has_many :shelves

  ### Secure Password ###
  has_secure_password

  ### Validations ###
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  ### Building and Updating Associations ###
  def add_shelf(shelf_name)
    self.shelves.create(name: shelf_name)
  end

  def destroy_empty_shelves
    self.shelves.each do |shelf|
      shelf.destroy if shelf.books.empty?
    end
  end

  ### Friendly Name ###
  def firstname
    self.name.split(' ')[0]
  end

end
