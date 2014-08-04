get '/users/new' do
  @user = User.new 
  erb :"users/new"
end

post '/users' do 
  @user = User.create(:email => params[:email],
              :password => params[:password],
              :password_confirmation => params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :"users/new"
  end

end

get '/recover' do 
  erb :"/recover"
end

post '/recover' do
  email = params[:email]
  user = User.first(email: email)
  if user
    user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
    user.password_token_timestamp = Time.now
    user.save
    user.send_password_reset
    erb :"/request_password"
  else
    flash[:notice] = ["You cannot reset a password for an unregistered user. Please register first."]
    redirect to('/sessions/new')
  end
end

post '/request_password' do
  erb :"/request_password"
end

get '/users/reset_password/:token' do
  puts request.url
  @user = User.first(:password_token => params[:token])
    if within_an_hour? @user.password_token_timestamp.to_time
      erb :"users/reset_password/:token"
    else 
      flash[:notice] = "Your token has expired. Please request another password"
      redirect to('/recover')
    end
end

post '/users/reset_password' do
  @user = User.first(:password_token => params[:password_token])
  @user.password = params[:password]
  @user.password_confirmation = params[:password_confirmation]
  @user.password_token = nil
  @user.password_token_timestamp = nil
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :"/users/reset_password/:token"
    end
      
end