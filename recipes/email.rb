include_recipe 'postfix'

# We don't need Exim as we use Postfix
package 'exim4' do
  action :remove
end
