# web server
default[:gallery3][:webserver][:docroot] = '/gallery3'
default[:gallery3][:webserver][:alias] = 'gallery3.local'

# database connection
default[:gallery3][:database][:host] = 'localhost'
default[:gallery3][:database][:name] = 'gallery3'
default[:gallery3][:database][:username] = 'root'
default[:gallery3][:database][:password] = ''

# Gallery3
default[:gallery3][:admin][:password] = 'adminsecret'
default[:gallery3][:admin][:email] = 'admin@example.com'
