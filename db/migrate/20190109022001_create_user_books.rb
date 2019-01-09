class CreateUserBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :finished_book, default: false
      t.datetime :finish_date
      t.integer :rating
      t.text :review

      t.timestamps
    end
  end
end
