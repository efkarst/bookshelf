class BookFinder < ApplicationRecord

  def self.search_google_books_by_title(search)
    book_list = retrieve_json("https://www.googleapis.com/books/v1/volumes?q=#{search.split(' ').join('-')}")
    @books = []
    10.times do |i|
      book = book_list["items"][i]
      @books << Book.new(google_book_attributes(book))
    end
    @books
  end

  def self.search_google_books_by_identifier(identifier)
    book = retrieve_json("https://www.googleapis.com/books/v1/volumes/#{identifier}")
    Book.new(google_book_attributes(book))
  end

  def self.google_book_attributes(book)
    book_attributes = {
        title: book["volumeInfo"]["title"],
        author: book["volumeInfo"]["authors"] ? Author.new(name: book["volumeInfo"]["authors"].first) : Author.new(name: 'unknown'),
        genre: book["volumeInfo"]["categories"] ? Genre.new(name: book["volumeInfo"]["categories"].first) : Genre.new(name: 'unknown'),
        cover_image: book["volumeInfo"]["imageLinks"] ? book["volumeInfo"]["imageLinks"]["smallThumbnail"] : "book_placeholder.png", 
        description: book["volumeInfo"]["description"] ? book["volumeInfo"]["description"] : "",
        pages: book["volumeInfo"]["pageCount"] ? book["volumeInfo"]["pageCount"] : "",
        identifier: book["id"]
      }
  end

  def self.retrieve_json(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end

