class CreateBookShelves < ActiveRecord::Migration[5.2]
  def change
    create_table :book_shelves do |t|
      t.integer :book_id
      t.integer :shelf_id

      t.timestamps
    end
  end
end
