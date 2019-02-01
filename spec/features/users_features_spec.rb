require 'rails_helper'

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

