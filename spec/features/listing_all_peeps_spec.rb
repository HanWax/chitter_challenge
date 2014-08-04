require 'spec_helper'

feature 'User browses the list of peeps' do

  before(:each) {
    Peep.create(:content => "My first peep", :time_stamp => Time.now)
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("My first peep")
  	end
end