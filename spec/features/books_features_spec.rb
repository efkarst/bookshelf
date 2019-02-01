require 'rails_helper'

def app
  ApplicationController
end

describe 'Add books to collection' do
  before do
    create_standard_users
    visit '/'
    click_link('Sign In')
    user_1_signin
  end
  
  it "allows a user to search for book and add to collection" do
    add_book_by_search
  end

  it "allows a user to add a book from another users collection by browsing" do
    # Add a book to abigail's collection
    add_book_by_search

    # Logout and log in as frank
    visit '/logout'
    click_link('Sign In')
    user_2_signin

    # Browse for books to add
    visit '/books'
    click_on("SiFa-XvuQmAC")
    expect(current_path).to eq("/users/2")
    expect(page).to have_content("Adventures of Huckleberry Finn")
  end
end

describe 'Remove books from collection' do
  before do
    create_standard_users # create users
    visit '/'
    click_link('Sign In')
    user_1_signin # sign in 
    add_book_by_search # Add a book to abigail's collection
  end
  
  it "allows user to remove a book from their collection" do
    click_on("SiFa-XvuQmAC")
    expect(current_path).to eq("/users/1")
    expect(page).to_not have_content("Adventures of Huckleberry Finn")
  end
end

describe 'User Book Activity' do
  before do
    create_standard_users # create users
    visit '/'
    click_link('Sign In')
    user_1_signin # sign in 
    add_book_by_search # Add a book to abigail's collection
  end

  it "allows user to mark book as read" do
    visit '/books/1'
    expect(page).to have_content("Adventures of Huckleberry Finn")

    check("user_book_finished_book")
    click_on("Update Activity")

    expect(current_path).to eq("/books/1")
    expect(page).to have_content("Adventures of Huckleberry Finn")
    expect(page).to have_checked_field("user_book[finished_book]")
  end

end
