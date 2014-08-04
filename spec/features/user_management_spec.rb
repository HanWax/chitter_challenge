require 'spec_helper'

require_relative 'helpers/session'
include SessionHelpers

feature "User signs up" do

  scenario "when being logged out" do    
    lambda { sign_up }.should change(User, :count).by(1)    
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")        
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
end

feature 'User signs out' do

  before(:each) do
    User.create(:email => "hannah@example.com", 
                :password => 'hello', 
                :password_confirmation => 'hello')
  end

  scenario 'while being signed in' do
    sign_in('hannah@example.com', 'hello')
    click_button "Sign out"
    expect(page).to have_content("Goodbye!")
    expect(page).not_to have_content("Welcome, hannah@example.com")
  end
end