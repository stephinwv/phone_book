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

end
get '/selection'do
first_name = params[:first_name]
last_name = params[:last_name]
address = params[:address]
city = params[:city]
state = params[:state]
zip = params[:zip]
phone = params[:phone]
email = params[:email]
phonebook = params[:phonebook]

erb :selection, locals:{first_name: first_name, last_name:last_name, address:address, city: city, state: state, zip: zip, phone: phone, email: email}
end