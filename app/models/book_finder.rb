class BookFinder < ApplicationRecord
  ### Find Google Books ###

  # Search Google Books by Title --> return array of instantiated book instances that match that title (top 10 matches)
  def self.search_google_books_by_title(search)
    book_list = retrieve_json("https://www.googleapis.com/books/v1/volumes?q=#{search.split(' ').join('-')}")
    @books = []
    if book_list["items"]
      10.times do |i|
        book = book_list["items"][i]
        @books << Book.new(google_book_attributes(book))
      end
    end
    @books
  end

  # Search Google Books by Google Identifier --> return an instantiated instance of the book matching that identifier
  def self.search_google_books_by_identifier(identifier)
    book = retrieve_json("https://www.googleapis.com/books/v1/volumes/#{identifier}")
    Book.new(google_book_attributes(book))
  end

  # Build hash of attributes from Google JSON
  def self.google_book_attributes(book)
    book_attributes = {
        title: book["volumeInfo"]["title"],
        author: book["volumeInfo"]["authors"] ? Author.new(name: book["volumeInfo"]["authors"].first) : Author.new(name: 'unknown'),
        genre: book["volumeInfo"]["categories"] ? Genre.new(name: book["volumeInfo"]["categories"].first) : Genre.new(name: 'unknown'),
        cover_image: book["volumeInfo"]["imageLinks"] ? book["volumeInfo"]["imageLinks"]["thumbnail"] : "book_placeholder.png", 
        description: book["volumeInfo"]["description"] ? book["volumeInfo"]["description"] : "",
        pages: book["volumeInfo"]["pageCount"] ? book["volumeInfo"]["pageCount"] : "",
        identifier: book["id"]
      }
  end

  # Call API and return JSON
  def self.retrieve_json(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end

