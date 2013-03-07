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
include_recipe 'gallery3::email'
include_recipe 'gallery3::php'

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
