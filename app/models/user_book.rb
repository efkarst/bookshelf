class UserBook < ApplicationRecord
  ### Associations ###
  belongs_to :user 
  belongs_to :book
  belongs_to :review, optional: true

  ### Validations ###
  validates :review, presence: false

  ### Building and Updating Associations ###
  def shelf_ids=(shelf_ids)
    remove_book_from_shelves(self.book,self.user)      
    shelf_ids[1..-1].each do |shelf_id|
      Shelf.find(shelf_id).books << self.book
    end
    user.destroy_empty_shelves
  end

  def remove_book_from_shelves(book,user)
    shelves.each do |shelf|
      shelf.book_shelves.where("book_id=#{book.id}").each do |bookshelf|
        bookshelf.destroy if (Time.now.utc - shelf.created_at.utc > 5)
      end
    end
  end

  def shelf_ids
    shelves.collect { |shelf| shelf.id }
  end

  def shelves
    self.user.shelves & self.book.shelves
  end

  def shelf_name=(shelf_name)
    if shelf_name != ""
      shelf = self.user.shelves.find_or_create_by(name: shelf_name)
      shelf.books << self.book
    end
  end

  def shelf_name
  end

  def shelves_attributes=(shelf_attributes)
    binding.pry
    shelf_attributes.values.each do |shelf_attribute|
      if !shelf_attribute[:name].blank?
        shelf = Shelf.find_or_create_by(shelf_attribute)
        self.user.shelves << shelf
        self.book.shelves << shelf
        self.user.save 
        self.book.save 
        self.save
      end
    end
  end
end
