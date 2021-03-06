module LoginHelper

  def user_signup
    fill_in("user_name", :with => "Abigail Frank")
    fill_in("user_email", :with => "abs@email.com")
    fill_in("user_password", :with => "password")
    click_on('Sign Up')
    expect(current_path).to eq("/users/1")
    expect(page).to have_content("Abigail")
  end

  def user_1_signin
    fill_in("email", :with => "abs@email.com")
    fill_in("password", :with => "password")
    click_on('Sign In')
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Abigail")
  end

  def user_2_signin
    fill_in("email", :with => "fred@frink.com")
    fill_in("password", :with => "password")
    click_on('Sign In')
  end

  def create_standard_users
    @u1 = User.create(name: "Abigail Frank", email:"abs@email.com", password: "password")
    @u2 = User.create(name: "Fred Frink", email: "fred@frink.com", password: "password")
  end
  
end