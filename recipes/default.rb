#
# Cookbook Name:: doventia-rb
# Recipe:: default
#
# Copyright (C) 2014 Redradix
#
# All rights reserved - Do Not Redistribute
#

# Environment

home_dir = "/home/vagrant"
development_dir = "#{home_dir}/Development"
projects_dir = "#{development_dir}/projects"

include_recipe 'apt'
include_recipe 'vim'
include_recipe 'git'

directory projects_dir do
  owner 'vagrant'
  group 'vagrant'
  recursive true
end

# Uncommented after adding ssh keys to Vagrant VM
git "clone doventia-rb" do
  repository "git@bitbucket.org:redradix/doventia-rb.git"
  reference "master"
  action :sync
  destination "#{projects_dir}/doventia-rb"
end

# Uncommented after adding ssh keys to Vagrant VM
git "clone dotfiles" do
  repository "git@github.com:dsaenztagarro/dotfiles.git"
  reference "master"
  action :sync
  destination "#{projects_dir}/dotfiles"
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

postgresql_database 'doventia_development' do
  connection postgresql_connection_info
  action :create
end

postgresql_database 'doventia_test' do
  connection postgresql_connection_info
  action :create
end

# create a mysql user but grant no privileges
postgresql_database_user 'development' do
  connection postgresql_connection_info
  password   'development'
  action     :create
end

# Grant all privileges on all tables in doventia_development db
postgresql_database_user 'development' do
  connection    postgresql_connection_info
  database_name 'doventia_development'
  privileges    [:all]
  action        :grant
end


# Grant all privileges on all tables in doventia_test db
postgresql_database_user 'development' do
  connection    postgresql_connection_info
  database_name 'doventia_test'
  privileges    [:all]
  action        :grant
end

node.default['sphinx']['use_mysql'] = true
node.default['sphinx']['use_postgres'] = true
node.default['sphinx']['version'] = '2.0.8'
include_recipe 'sphinx'


# Backend

node.default['rvm']['default_ruby'] = 'ruby-2.1.0'
node.default['rvm']['rubies'] = ['ruby-2.1.0']
node.default['rvm']['vagrant']['system_chef_solo'] = '/opt/chef/bin/chef-solo'
include_recipe 'rvm::vagrant'
include_recipe 'rvm::system'

node.default['nodejs']['version'] = '0.10.28'
include_recipe 'nodejs'
