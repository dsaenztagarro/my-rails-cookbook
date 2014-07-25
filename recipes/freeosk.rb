include_recipe "my-environment"

node.default['mysql']['version'] = '5.5'
node.default['mysql']['server_root_password'] = 'root'
include_recipe 'mysql::server'
include_recipe 'mysql::client'

include_recipe 'database'
include_recipe 'database::mysql'

mysql_connection_info = {
  :host     => 'localhost',
  :port     => node['mysql']['port'].to_i,
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database 'freeosk_development' do
  connection mysql_connection_info
  action :create
end

mysql_database 'freeosk_test' do
  connection mysql_connection_info
  action :create
end

mysql_database_user 'development' do
  connection    mysql_connection_info
  password      'development'
  database_name 'freeosk_development'
  host          '%'
  privileges    [:all]
  action        :grant
end

mysql_database_user 'development' do
  connection    mysql_connection_info
  password      'development'
  database_name 'freeosk_test'
  host          '%'
  privileges    [:all]
  action        :grant
end
