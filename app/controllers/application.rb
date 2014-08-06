get '/' do
  @peeps = Peep.all
  @replies = Reply.all
  erb :index
end