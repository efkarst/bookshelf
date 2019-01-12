class BookFinder < ApplicationRecord

  def self.search_google_books(search)
    uri = URI("https://www.googleapis.com/books/v1/volumes?q=#{search.split(' ').join('-')}")
    response = Net::HTTP.get(uri)
    book_list = JSON.parse(response)

    book_attributes = {
      title: book_list["items"].first["volumeInfo"]["title"],
      author: Author.new(name: book_list["items"].first["volumeInfo"]["authors"].first),
      genre: Genre.new(name: book_list["items"].first["volumeInfo"]["categories"].first),
      cover_image: book_list["items"].first["volumeInfo"]["imageLinks"]["thumbnail"],
      description: book_list["items"].first["volumeInfo"]["description"],
      pages: book_list["items"].first["volumeInfo"]["pageCount"],
      isbn: book_list["items"].first["volumeInfo"]["industryIdentifiers"].first["identifier"]
    }
    @book = Book.new(book_attributes)
  end
end

# t.string "title"
# t.integer "pages"
# t.text "description"
# t.string "cover_image"
# t.string "isbn"
# t.integer "genre_id"
# t.integer "author_id"
