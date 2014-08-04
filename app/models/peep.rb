class Peep

  include DataMapper::Resource

  property :id,         Serial 
  property :content,    Text,    :length => 0..140
  property :time_stamp, Time


  # belongs_to :user

  def time_stamp_formatted
  	Time.now.asctime
  end 
end