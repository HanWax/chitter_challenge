require 'spec_helper'

feature "User signs up" do

  scenario "when being logged out" do    
    lambda { sign_up }.should change(User, :count).by(1)    
    expect(page).to have_content("Welcome, hannah@example.com")
    expect(User.first.email).to eq("hannah@example.com")        
  end

  scenario "with a password that doesn't match" do
    lambda { sign_up('hannah@example.com', 'pass', 'wrong') }.should change(User, :count).by(0) 
    expect(current_path).to eq('/users')   
    expect(page).to have_content(" Password does not match the confirmation")
  end

  scenario "with an email that is already registered" do    
    lambda { sign_up }.should change(User, :count).by(1)
    lambda { sign_up }.should change(User, :count).by(0)
    expect(page).to have_content("This email is already taken")
  end

  def sign_up(email = "hannah@example.com", 
              password = "ladybird",
              password_confirmation = 'ladybird')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end

end

feature "User signs in" do

  before(:each) do
    User.create(:email => "hannah@example.com", 
                :password => 'hello', 
                :password_confirmation => 'hello')
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, hannah@example.com")
    sign_in('hannah@example.com', 'hello')
    expect(page).to have_content("Welcome, hannah@example.com")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, hannah@example.com")
    sign_in('hannah@example.com', 'wrong')
    expect(page).not_to have_content("Welcome, hannah@example.com")
  end

  def sign_in(email, password)
    visit '/sessions/new'
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

end