include_recipe 'apache2'
include_recipe 'apache2::mod_php5'

service 'apache2' do
  action :enable
end

web_app node[:gallery3][:webserver][:alias] do
  server_name node[:hostname]
  server_aliases [node[:fqdn], node[:gallery3][:webserver][:alias]]
  docroot node[:gallery3][:webserver][:docroot]
  template 'gallery3.httpd.conf.erb'
end
