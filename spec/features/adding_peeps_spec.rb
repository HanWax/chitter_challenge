require 'spec_helper'

feature "User adds a new peep" do
  scenario "when browsing the homepage" do
    expect(Peep.count).to eq(0)
    visit '/'
    add_peep("I'm getting the hang of peeping")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.content).to eq("I'm getting the hang of peeping")
  end

  def add_peep(content)
    within('#new-peep') do
      fill_in 'content', :with => content
      click_button 'Send Peep'
    end      
  end
end