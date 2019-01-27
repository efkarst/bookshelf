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
    user_signup
  end
end

describe 'User Login' do
  before do
    create_standard_users
  end
  
  it "allows a user to sign in" do
    visit '/'
    click_link('Sign In')
    user_1_signin
  end
end
# visit     page     fill_in     check     uncheck     choose     click_link     click_button     click_on

# fill_in("ship_name_1", :with => "Flying Dutchman")

# expect(page).to have_content("Captain Jack Sparrow")

# expect(current_path).to eq('/users/home')

#https://travis-ci.org/
