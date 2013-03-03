include_recipe 'mysql::server'
include_recipe 'database::mysql'

service 'mysql' do
  action :enable
end

database_connection = {
  :host => node[:gallery3][:database][:host],
  :username => 'root',
  :password => node[:mysql][:server_root_password]
}

mysql_database node[:gallery3][:database][:name] do
  connection database_connection
  action :create
end

mysql_database_user node[:gallery3][:database][:username] do
  connection database_connection
  password node[:gallery3][:database][:password]
  action :create
end

mysql_database_user node[:gallery3][:database][:username] do
  connection database_connection
  password node[:gallery3][:database][:password]
  database_name node[:gallery3][:database][:name]
  privileges [:all]
  action :grant
end
