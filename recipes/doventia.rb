# Environment

include_recipe "my-environment"

# Uncommented after adding ssh keys to Vagrant VM
git "clone doventia-rb" do
  repository "git@bitbucket.org:redradix/doventia-rb.git"
  reference "master"
  action :sync
  destination "#{projects_dir}/doventia-rb"
end

# Database

node.default['postgresql']['version'] = '9.3'
node.default['postgresql']['password']['postgres'] = 'postgres'
include_recipe 'postgresql::server'
include_recipe 'postgresql::client'

node.default['mysql']['version'] = '5.5'
node.default['mysql']['server_root_password'] = 'root'
include_recipe 'mysql::server'
include_recipe 'mysql::client'

include_recipe 'database'
include_recipe 'database::postgresql'

postgresql_connection_info = {
  :host     => '127.0.0.1',
  :port     => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

# create a mysql user but grant no privileges
postgresql_database_user 'development' do
  connection postgresql_connection_info
  password   'development'
  action     :create
end

postgresql_database 'doventia_development' do
  connection postgresql_connection_info
  owner 'development'
  action :create
end

postgresql_database 'doventia_test' do
  connection postgresql_connection_info
  owner 'development'
  action :create
end

# Grant all privileges on all tables in doventia_development db
postgresql_database_user 'development' do
  connection    postgresql_connection_info
  database_name 'doventia_development'
  privileges    ['ALL PRIVILEGES']
  action        :grant
end


# Grant all privileges on all tables in doventia_test db
postgresql_database_user 'development' do
  connection    postgresql_connection_info
  database_name 'doventia_test'
  privileges    ['ALL PRIVILEGES']
  action        :grant
end

postgresql_database 'postgres' do
  connection    postgresql_connection_info
  sql 'ALTER ROLE development CREATEDB;'
  action :query
end
