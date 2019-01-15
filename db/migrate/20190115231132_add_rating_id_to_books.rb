class AddRatingIdToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :user_books, :rating_id, :integer
    remove_column :user_books, :rating, :integer
    remove_column :user_books, :review, :text
  end
end
