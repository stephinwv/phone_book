require 'sinatra'
require 'pony'
require 'pg'


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
	phonebook = db.exec("Select * From phonebook")
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
	redirect '/'
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
   	db.exec("UPDATE phonebook SET address = '#{new_data}' WHERE street_address = '#{old_data}' ");
   when 'col_city'
   	db.exec("UPDATE phonebook SET city = '#{new_data}' WHERE city = '#{old_data}' ");
   when 'col_state'
   	db.exec("UPDATE phonebook SET state = '#{new_data}' WHERE state = '#{old_data}' ");
   when 'col_zip'
   	db.exec("UPDATE phonebook SET zip = '#{new_data}' WHERE zip = '#{old_data}' ");
   when 'col_cell'
   	db.exec("UPDATE phonebook SET phone = '#{new_data}' WHERE phone = '#{old_data}' ");
   when 'col_home'
	db.exec("UPDATE phonebook SET email = '#{new_data}' WHERE email = '#{old_data}' ");
	end
   redirect '/'
end

post '/delete_all' do
	db.exec("TRUNCATE phonebook");
	redirect '/'
end