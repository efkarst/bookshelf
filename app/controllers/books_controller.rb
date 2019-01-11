# require 'httparty'

class BooksController < ApplicationController

  def index
    @books = Book.all 
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    uri = URI("https://www.googleapis.com/books/v1/volumes?q=#{params[:search].split(' ').join('-')}")
    response = Net::HTTP.get(uri)
    book_list = JSON.parse(response)

    title = book_list["items"].first["volumeInfo"]["title"]
    # author = book_list["items"].first["volumeInfo"]["authors"].first
    @book = Book.create(title: title)

    render 'search'
  end

  def create_from_search
    binding.pry
  end

end
