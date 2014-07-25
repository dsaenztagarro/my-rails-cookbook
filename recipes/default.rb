#
# Cookbook Name:: doventia-rb
# Recipe:: default
#
# Copyright (C) 2014 Redradix
#
# All rights reserved - Do Not Redistribute
#

# Backend

node.default['sphinx']['use_mysql'] = true
node.default['sphinx']['use_postgres'] = true
node.default['sphinx']['version'] = '2.0.8'
include_recipe 'sphinx'

node.default['rvm']['default_ruby'] = 'ruby-2.0.0-p353'
node.default['rvm']['rubies'] = ['ruby-2.0.0-p353']
node.default['rvm']['vagrant']['system_chef_solo'] = '/opt/chef/bin/chef-solo'
include_recipe 'rvm::vagrant'
include_recipe 'rvm::system'

node.default['nodejs']['version'] = '0.10.28'
include_recipe 'nodejs'
