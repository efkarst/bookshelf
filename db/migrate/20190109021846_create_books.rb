class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :pages
      t.text :description
      t.string :cover_image
      t.string :isbn
      t.integer :genre_id

      t.timestamps
    end
  end
end
