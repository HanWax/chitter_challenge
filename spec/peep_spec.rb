require 'spec_helper'

describe Peep do

  context "Demonstration of how datamapper works" do

    it 'should be created and then retrieved from the db' do
      expect(Peep.count).to eq(0)
      Peep.create(:content => "My first peep", :time_stamp => Time.now)
      expect(Peep.count).to eq(1)
      peep = Peep.first
      expect(peep.content).to eq("My first peep")
      expect(peep.time_stamp).to eq(Time.now)
      peep.destroy
      expect(Peep.count).to eq(0)
    end

  end

end