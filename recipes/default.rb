#
# Cookbook Name:: gallery
# Recipe:: default
#
# Copyright (C) 2013 Gallery3
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'gallery3::database'
include_recipe 'gallery3::webserver'
include_recipe 'gallery3::php'

database_connection = {
  :host => node[:gallery3][:database][:host],
  :username => node[:gallery3][:database][:username],
  :password => node[:gallery3][:database][:password]
}

directory "#{node[:gallery3][:webserver][:docroot]}/var" do
  owner 'vagrant'
  group 'vagrant'
  mode 0777
  action :create
end

execute 'install Gallery3' do
  command <<-EOH
  php index.php \
    -u #{node[:gallery3][:database][:username]} \
    -p #{node[:gallery3][:database][:password]} \
    -d #{node[:gallery3][:database][:name]}
  EOH
  cwd "#{node[:gallery3][:webserver][:docroot]}/installer"
  not_if {File.exists?(node[:gallery3][:webserver][:docroot]+'/var/database.php')}
  notifies :query, "mysql_database[set default admin info]", :immediately
end

# set default admin password and email address after installation
mysql_database 'set default admin info' do
  connection database_connection
  database_name node[:gallery3][:database][:name]
  sql <<-SQL
  UPDATE users
  SET
    password = MD5('#{node[:gallery3][:admin][:password]}'),
    email = '#{node[:gallery3][:admin][:email]}'
  WHERE name = 'admin';
  SQL
  action :nothing
end

# install all toolkits
%w(graphicsmagick imagemagick php5-gd ffmpeg).each do |pkg|
  package pkg do
    action :install
    notifies :restart, 'service[apache2]', :delayed
  end
end

# install developer tools
%w(git-core).each do |pkg|
  package pkg do
    action :install
  end
end
