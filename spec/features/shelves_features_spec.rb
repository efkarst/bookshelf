require 'rails_helper'

# RSpec.describe SessionsController, type: :controller do

# end

def app
  ApplicationController
end

describe 'Create a new Shelf' do
  before do
    u1 = User.create(name: "Abigail Frank", email:"abs@email.com", password: "password")
    u2 = User.create(name: "Fred Frink", email: "fred@frink.com", password: "password")
    # u2.books.create(title: "Franks Book", author: Author.new(name: "Franks book author"), genre: Genre.new(name: "Franks book genre"))

    visit '/'

    click_link('Sign In')
    fill_in("email", :with => "abs@email.com")
    fill_in("password", :with => "password")
    click_on('Sign In')
  end
  
  it "allows a user to search for book and add to collection" do
    fill_in('searchbox-text', :with => "huckleberry finn")
    click_button('searchbox-button')
    expect(current_path).to eq("/books/search/new")
    expect(page).to have_content("Results for 'huckleberry finn'")
    click_on("SiFa-XvuQmAC")
    expect(current_path).to eq("/users/1")
    expect(page).to have_content("Adventures of Huckleberry Finn")
  end

  it "allows a user to add a book from another users collection by browsing" do
    # Add a book to abigail's collection
    fill_in('searchbox-text', :with => "huckleberry finn")
    click_button('searchbox-button')
    expect(current_path).to eq("/books/search/new")
    expect(page).to have_content("Results for 'huckleberry finn'")
    click_on("SiFa-XvuQmAC")
    expect(current_path).to eq("/users/1")
    expect(page).to have_content("Adventures of Huckleberry Finn")

    # Logout and log in as frank
    visit '/logout'
    click_link('Sign In')
    fill_in("email", :with => "fred@frink.com")
    fill_in("password", :with => "password")
    click_on('Sign In')

    # Browse for books to add
    visit '/books'
    click_on("SiFa-XvuQmAC")
    expect(current_path).to eq("/users/2")
    expect(page).to have_content("Adventures of Huckleberry Finn")
  end
end

describe 'Remove books from collection' do
  before do
    u1 = User.create(name: "Abigail Frank", email:"abs@email.com", password: "password")
    u2 = User.create(name: "Fred Frink", email: "fred@frink.com", password: "password")
    # u2.books.create(title: "Franks Book", author: Author.new(name: "Franks book author"), genre: Genre.new(name: "Franks book genre"))

    # sign in 
    visit '/'
    click_link('Sign In')
    fill_in("email", :with => "abs@email.com")
    fill_in("password", :with => "password")
    click_on('Sign In')

    # Add a book to abigail's collection
    fill_in('searchbox-text', :with => "huckleberry finn")
    click_button('searchbox-button')
    expect(current_path).to eq("/books/search/new")
    expect(page).to have_content("Results for 'huckleberry finn'")
    click_on("SiFa-XvuQmAC")
    expect(current_path).to eq("/users/1")
    expect(page).to have_content("Adventures of Huckleberry Finn")
  end
  
  it "allows user to remove a book from their collection" do
    click_on("SiFa-XvuQmAC")
    expect(current_path).to eq("/users/1")
    expect(page).to_not have_content("Adventures of Huckleberry Finn")
  end
end
# visit     page     fill_in     check     uncheck     choose     click_link     click_button     click_on

# fill_in("ship_name_1", :with => "Flying Dutchman")

# expect(page).to have_content("Captain Jack Sparrow")

# expect(current_path).to eq('/users/home')

#https://travis-ci.org/
