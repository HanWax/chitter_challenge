require 'data_mapper'
require 'sinatra'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/peep' 
require './lib/user'

DataMapper.finalize

DataMapper.auto_upgrade!

set :views, Proc.new { File.join(root, "app", "views") }
enable :sessions
set :session_secret, 'secret'

get '/' do
  @peeps = Peep.all
  erb :index
end

post '/peeps' do
  content = params["content"]
  Peep.create(:content => content)
  redirect to('/')
end

get '/users/new' do
  erb :"users/new"
end

post '/users' do
  user = User.create(:email => params[:email], 
              :password => params[:password])
  session[:user_id] = user.id
  redirect to('/')
end

helpers do

  def current_user    
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end

end

