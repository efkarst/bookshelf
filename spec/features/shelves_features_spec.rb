require 'rails_helper'

def app
  ApplicationController
end

describe 'Create Shelves' do
  before do
    create_standard_users
    visit '/'
    click_link('Sign In')
    user_1_signin
    add_book_by_search
  end
  
  it "allows a user to create a new shelf" do
    create_new_shelf

    # validate book is added to shelf
    find("a[href='/users/1/shelves/1']").click
    expect(page).to have_content("Fiction")
    expect(page).to have_content("Adventures of Huckleberry Finn")

  end

  it "allows a user to create a shelf from a book" do 
    create_new_shelf
    visit '/books/1'
    expect(page).to have_content("Adventures of Huckleberry Finn")

    # add book to one existing and one new shelf
    check('user_book_shelf_ids_1')
    fill_in("user_book_shelf_name", :with => "Classics")
    click_on("Update Shelves")

    # validate book belongs to shelves
    expect(current_path).to eq("/books/1")
    expect(page).to have_checked_field("user_book_shelf_ids_1")
    expect(page).to have_checked_field("user_book_shelf_ids_2")
  end
end

describe 'Edit Shelves' do
  before do
    
  end
  
  it "allows a user to edit a shelf" do
   
  end

  it "allows a user to edit shelves from a book" do
   
  end
end

describe 'Destroy Shelves' do
  before do
    
  end
  
  it "allows a user to destroy a shelf" do
    
  end

  it "destroys a shelf if a user removes all books from it" do
   
  end
end

# visit     page     fill_in     check     uncheck     choose     click_link     click_button     click_on

# fill_in("ship_name_1", :with => "Flying Dutchman")

# expect(page).to have_content("Captain Jack Sparrow")

# expect(current_path).to eq('/users/home')

#https://travis-ci.org/
