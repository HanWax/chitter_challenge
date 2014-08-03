env = ENV["RACK_ENV"] || "development"
 	if ENV["RACK_ENV"] == "production"
 		DataMapper.setup(:default, ENV["DATABASE_URL"])
	else
		DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
 	end

require './lib/peep'
require './lib/user'

# Run "DataMapper.auto_migrate!" to reboot database

DataMapper.finalize