env = ENV["RACK_ENV"] || "development"
 	if ENV["RACK_ENV"] == "production"
 		DataMapper.setup(:default, ENV["DATABASE_URL"])
	else
		DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
 	end

require './app/models/peep'
require './app/models/user'


# Run "DataMapper.auto_migrate!" to reboot database

DataMapper.finalize
