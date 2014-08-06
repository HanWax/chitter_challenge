helpers do

  def current_user    
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end

  def within_an_hour? time
    	time >= (Time.now - 3600)
  end

  def time_stamp_formatted
  	Time.now.asctime
  end 
end
