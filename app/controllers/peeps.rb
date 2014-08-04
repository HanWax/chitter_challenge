get '/peeps/new' do
  erb :"peeps/new"
end

post '/peeps' do
	content = params["content"]
    @peep = Peep.create(:content => content, :time_stamp => Time.now)
    if @peep.save
      flash[:notice] = "Peep sent successfully!"
    else
      flash[:error] = ["Could not post your peep :("]
    end
    redirect to('/')
end

