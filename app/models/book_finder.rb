class BookFinder < ApplicationRecord

  def self.search_google_books_by_title(search)
    uri = URI("https://www.googleapis.com/books/v1/volumes?q=#{search.split(' ').join('-')}")
    response = Net::HTTP.get(uri)
    book_list = JSON.parse(response)["items"]

    @books = []
    10.times do |i|
      book = book_list[i]["volumeInfo"]
      book_attributes = {
        title: book["title"],
        author: book["authors"] ? Author.new(name: book["authors"].first) : Author.new(name: 'unknown'),
        genre: book["categories"] ? Genre.new(name: book["categories"].first) : Genre.new(name: 'unknown'),
        cover_image: book["imageLinks"] ? book["imageLinks"]["smallThumbnail"] : "book_placeholder.png", 
        description: book["description"] ? book["description"] : "",
        pages: book["pageCount"] ? book["pageCount"] : "",
        identifier: book["industryIdentifiers"].first["identifier"]
      }
      @books << Book.new(book_attributes)
    end
    @books
  end

  def self.search_google_books_by_id(id)
  end
end

