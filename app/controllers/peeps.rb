get '/peeps/new' do
  erb :"peeps/new"
end

post '/peeps' do
	content = params["content"]
	time_stamp = params["time_stamp"]
    
    if session[:user_id] 
      @peep = Peep.create(:content => content, :time_stamp => Time.now.asctime, :user_id => User.first.id)
      flash[:notice] = "Peep sent successfully!"
    else
      flash[:notice] = "Could not post your peep :( Have you tried signing in?"
    end
    redirect to('/')
end

