include_recipe 'php'

package 'php5-mysql' do
  notifies :restart, 'service[apache2]', :delayed
end
