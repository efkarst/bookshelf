class BookFinder < ApplicationRecord

  def self.search_google_books_by_title(search)
    uri = URI("https://www.googleapis.com/books/v1/volumes?q=#{search.split(' ').join('-')}")
    response = Net::HTTP.get(uri)
    book_list = JSON.parse(response)

    @books = []
    10.times do |i|
      book_attributes = {
        title: book_list["items"][i]["volumeInfo"]["title"],
        author: Author.new(name: book_list["items"][i]["volumeInfo"]["authors"].first),
        genre: book_list["items"][i]["volumeInfo"]["categories"] ? Genre.new(name: book_list["items"][i]["volumeInfo"]["categories"].first) : Genre.new(name: 'unknown'),
        cover_image: book_list["items"][i]["volumeInfo"]["imageLinks"]["smallThumbnail"],
        description: book_list["items"][i]["volumeInfo"]["description"],
        pages: book_list["items"][i]["volumeInfo"]["pageCount"],
        identifier: book_list["items"][i]["volumeInfo"]["industryIdentifiers"].first["identifier"]
      }
      @books << Book.new(book_attributes)
    end
    @books
  end

  def self.search_google_books_by_id(id)
  end
end

