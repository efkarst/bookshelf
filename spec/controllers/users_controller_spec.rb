require 'rails_helper'

def app
  ApplicationController
end

describe 'User Signup' do
  it "allows a user to signup" do
    visit '/'

    click_link('Sign Up')
    fill_in("user_name", :with => "Abigail Frank")
    fill_in("user_email", :with => "abs@email.com")
    fill_in("user_password", :with => "password")
    
    click_on('Sign Up')
    expect(current_path).to eq("/users/1")
    expect(page).to have_content("Abigail")
    expect(page).to have_content("Read")
    expect(page).to have_content("Unread")
  end
end

# visit     page     fill_in     check     uncheck     choose     click_link     click_button     click_on

# fill_in("ship_name_1", :with => "Flying Dutchman")

# expect(page).to have_content("Captain Jack Sparrow")

# expect(current_path).to eq('/users/home')

#https://travis-ci.org/