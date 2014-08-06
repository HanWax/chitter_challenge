require 'spec_helper'

describe "replying to peeps" do 

	scenario "when replying" do
    expect(Reply.count).to eq(0)
    visit '/'
    reply_to_peep("Thanks for peeping that interesting link")
    expect(Reply.count).to eq(1)
    reply = Reply.first
    expect(reply.content).to eq("Thanks for peeping that interesting link")
  end
end 