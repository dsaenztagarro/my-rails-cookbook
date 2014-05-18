#
# Cookbook Name:: doventia-rb
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node.set['postgresql']['version'] = '9.3'
node.set['postgresql']['password']['postgres'] = 'root'
include_recipe "postgresql::server"

node.set['mysql']['server_root_password'] = 'root'
include_recipe "mysql::server"
