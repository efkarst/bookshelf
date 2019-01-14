require 'rails_helper'

# RSpec.describe SessionsController, type: :controller do

# end

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
  end
end

describe 'User Login' do
  before do
    User.create(name: "Abigail Frank", email:"abs@email.com", password: "password")
  end
  
  it "allows a user to login" do
    visit '/'

    click_link('Sign In')
    fill_in("email", :with => "abs@email.com")
    fill_in("password", :with => "password")
    
    click_on('Sign In')
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Abigail")
  end
end
# visit     page     fill_in     check     uncheck     choose     click_link     click_button     click_on

# fill_in("ship_name_1", :with => "Flying Dutchman")

# expect(page).to have_content("Captain Jack Sparrow")

# expect(current_path).to eq('/users/home')

#https://travis-ci.org/
