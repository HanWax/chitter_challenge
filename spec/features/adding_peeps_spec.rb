require 'spec_helper'

feature "User adds a new peep" do
	
  scenario "when browsing the peep pages" do
    expect(Peep.count).to eq(0)
    visit '/'
    add_peep("I'm getting the hang of peeping")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.content).to eq("I'm getting the hang of peeping")
  end

  scenario "when being signed out it should not post peeps" do 
  	expect(Peep.count).to eq(0)
    visit '/'
    add_peep("I'm getting the hang of peeping")
    expect(Peep.count).to eq(1)
  end 


end