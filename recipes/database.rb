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

# create default database
mysql_database node[:gallery3][:database][:name] do
  connection database_connection
  action :create
end

mysql_database_user node[:gallery3][:database][:username] do
  connection database_connection
  password node[:gallery3][:database][:password]
  action :create
  not_if {node[:gallery3][:database][:username] == 'root'}
end

mysql_database_user node[:gallery3][:database][:username] do
  connection database_connection
  password node[:gallery3][:database][:password]
  database_name node[:gallery3][:database][:name]
  privileges [:all]
  action :grant
end

# create unit test database
unit_test_database_name = "#{node[:gallery3][:database][:name]}_test"
mysql_database unit_test_database_name do
  connection database_connection
  action :create
end

mysql_database_user node[:gallery3][:database][:username] do
  connection database_connection
  password node[:gallery3][:database][:password]
  database_name unit_test_database_name
  privileges [:all]
  action :grant
end

# allow remote access for root user (do not use this in production!)
mysql_database node[:gallery3][:database][:name] do
  connection database_connection
  sql "grant all privileges on *.* to 'root' identified by '';"
  action :query
end
