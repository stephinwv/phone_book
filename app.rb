require 'sinatra'
require 'pony'
require 'pg'
# require 'bcrypt'


load './local_env.rb' if File.exists?('./local_env.rb')

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db = PG::Connection.new(db_params)

get '/' do
	login_info = db.exec("Select * From login_info")
	login_info = params[:login_info]
	erb :login, locals: {login_info: login_info}
end

post '/register' do

	user_name = params[:user_name]
	pass_word = params[:pass_word]
	db.exec("INSERT INTO public.login_info (username, password) VALUES('#{user_name}', '#{pass_word}')")
	 
	redirect '/selection'
end
post '/login' do
	username = params[:username]
	password = params[:password]
	
	login_info = params[:login_info]
    redirect '/selection'

end

get '/selection' do
	phonebook = db.exec("Select * From phonebook");
	erb :selection, locals: {phonebook: phonebook}
end
post '/selection' do

	first_name = params[:first_name]
	last_name = params[:last_name]
	address = params[:address]
	city = params[:city]
	state = params[:state]
	zip = params[:zip]
	phone = params[:phone]
	email = params[:email]


	db.exec("INSERT INTO phonebook(first_name, last_name, address, city, state, zip, phone, email) VALUES('#{first_name}', '#{last_name}', '#{address}', '#{city}', '#{state}', '#{zip}', '#{phone}', '#{email}')");
	redirect '/selection'
end
post '/search' do
	column = params[:table_column]
	last_name = params[:last_name]
	# case column
	# when 'col_last_name'
	# 	db.exec("SELECT FROM phonebook WHERE  last_name LIKE '#{last_name}' ");
 #   	end
   redirect '/selection'
end

post '/update_column' do

   new_data = params[:new_data]
   old_data = params[:old_data]
   column = params[:table_column]

   	case column
   		when 'col_first_name'
   			db.exec("UPDATE phonebook SET first_name = '#{new_data}' WHERE first_name = '#{old_data}' ");
   		when 'col_last_name'
   			db.exec("UPDATE phonebook SET last_name = '#{new_data}' WHERE last_name = '#{old_data}' ");
   		when 'col_address'
   			db.exec("UPDATE phonebook SET address = '#{new_data}' WHERE address = '#{old_data}' ");
   		when 'col_city'
   			db.exec("UPDATE phonebook SET city = '#{new_data}' WHERE city = '#{old_data}' ");
   		when 'col_state'
   			db.exec("UPDATE phonebook SET state = '#{new_data}' WHERE state = '#{old_data}' ");
   		when 'col_zip'
   			db.exec("UPDATE phonebook SET zip = '#{new_data}' WHERE zip = '#{old_data}' ");
   		when 'col_phone'
   			db.exec("UPDATE phonebook SET phone = '#{new_data}' WHERE phone = '#{old_data}' ");
   		when 'col_email'
			db.exec("UPDATE phonebook SET email = '#{new_data}' WHERE email = '#{old_data}' ");
	end
   redirect '/selection'
end

post "/delete" do
        deleted = params[:data_to_delete]
        column = params[:table_column]
    case column
   		when 'col_first_name'
        	db.exec("DELETE FROM phonebook WHERE first_name = '#{deleted}'")
    	when 'col_last_name'
       		db.exec("DELETE FROM phonebook WHERE last_name = '#{deleted}'");
   		when 'col_address'
        	db.exec("DELETE FROM phonebook WHERE address = '#{deleted}'");
    	when 'col_city'
        	db.exec("DELETE FROM phonebook WHERE city = '#{deleted}'");
    	when 'col_state'
        	db.exec("DELETE FROM phonebook WHERE state = '#{deleted}'");
    	when 'col_zip'
        	db.exec("DELETE FROM phonebook WHERE zip = '#{deleted}'");        
    	when 'col_phone'
        	db.exec("DELETE FROM phonebook WHERE phone = '#{deleted}'");
    	when 'col_email'
     	db.exec("DELETE FROM phonebook WHERE email = '#{deleted}'");
    end
     redirect '/selection'
end