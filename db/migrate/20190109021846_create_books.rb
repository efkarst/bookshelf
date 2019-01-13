class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author_id
      t.integer :pages
      t.text :description
      t.string :cover_image
      t.string :identifier
      t.integer :genre_id

      t.timestamps
    end
  end
end
