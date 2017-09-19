require 'sinatra'
require 'pony'
require 'pg'


load "./local_env.rb" 

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db = PG::Connection.new(db_params)
post '/subscribe' do
	phone = params[:phone]
# 	check_phone = db.exec("SELECT * FROM mailing_list WHERE email = '#{email}'")
# 	if
# 		check_email.num_tuples.zero? == false
# 		erb :mailing_list, :locals => {:message => "You have already joined our mailing list"}
# 		else
# 			subscribe = db.exec("insert into mailing_list(email)VALUES('#{email}')")
# 			erb :mailing_list, :locals => {:message => "Thanks, for joining our mailing list."}
# end
end
get '/' do
erb :selection
end
post '/selection' do
phone = params[:phone]
erb :selection, locals: {phone: phone}
end