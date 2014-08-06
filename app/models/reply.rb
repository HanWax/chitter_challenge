class Reply

  include DataMapper::Resource

  property :id,         Serial 
  property :content,    Text,    :length => 0..140
  property :time_stamp, DateTime

  belongs_to :peep
end