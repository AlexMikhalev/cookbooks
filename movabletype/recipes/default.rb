#
# Cookbook Name:: movabletype
# Recipe:: default
#
# Copyright 2009-2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#                   
require_recipe "apt"
require_recipe "apache2"
require_recipe "apache2::mod_cgi"
require_recipe "perl"
# This is an optional modules
# FIXME: make sure movabletype dir is writeable by webserver

cpan_module "Crypt::DSA"
cpan_module "IPC::Run"
cpan_module  "Archive::Zip"
cpan_module  "HTML::Entities"
cpan_module  "Cache::File"
cpan_module  "Crypt::SSLeay"
require_recipe "imagemagick"
cpan_module  "GD"
cpan_module  "Digest::SHA1"
include_recipe "imagemagick::perlmagick"
cpan_module   "HTML::Parser"
require_recipe "xml"
cpan_module "XML::Atom"
cpan_module "XML::Parser" 

# libarchive-zip-perl




execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end   

# include_recipe "apache2"

if node.has_key?("ec2")
  server_fqdn = node.ec2.public_hostname
else
  # server_fqdn = node.fqdn
  server_fqdn='localhost:8080'
end


# Install Movable type 5
remote_file "#{Chef::Config[:file_cache_path]}/MT-#{node[:movabletype][:version]}-en.tar.gz" do
  checksum node[:movabletype][:checksum] 
  source "http://www.movabletype.com/downloads/blogger/MT-#{node[:movabletype][:version]}-en.tar.gz"
  Chef::Log.info("Fetching file")
  Chef::Log.info(source)
  mode "0644"
end

directory "#{node[:movabletype][:dir]}/" do
  owner "www-data"
  group "www-data"
  mode "0755"
  action :create
end  

directory "#{node[:movabletype][:dir]}/mt5/" do
  owner "www-data"
  group "www-data"
  mode "0755"
  action :create
end

execute "untar-movabletype" do
  cwd node[:movabletype][:dir]+"/mt5/"
  command "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/MT-#{node[:movabletype][:version]}-en.tar.gz"
  creates "#{node[:movabletype][:dir]}/mt5/mt-config.cgi"
end

directory "#{node[:movabletype][:dir]}/mt5/mt-static/support" do
  owner "www-data"
  group "www-data"
  mode "0755"
  action :create
  recursive true
end   

execute "mysql-install-mt-privileges" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} < /etc/mysql/mt-grants.sql"
  action :nothing
end

include_recipe "mysql::server"
require 'rubygems'
Gem.clear_paths
require 'mysql'

template "/etc/mysql/mt-grants.sql" do
  path "/etc/mysql/mt-grants.sql"
  source "grants.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  variables(
    :user     => node[:movabletype][:db][:user],
    :password => node[:movabletype][:db][:password],
    :database => node[:movabletype][:db][:database]
  )
  notifies :run, resources(:execute => "mysql-install-mt-privileges"), :immediately
end

execute "create #{node[:movabletype][:db][:database]} database" do
  command "/usr/bin/mysqladmin -u root -p#{node[:mysql][:server_root_password]} create #{node[:movabletype][:db][:database]}"
  not_if do
    m = Mysql.new("localhost", "root", node[:mysql][:server_root_password])
    m.list_dbs.include?(node[:movabletype][:db][:database])
  end
end

# save node data after writing the MYSQL root password, so that a failed chef-client run that gets this far doesn't cause an unknown password to get applied to the box without being saved in the node data.
ruby_block "save node data" do
  block do
    node.save
  end
  action :create
end 

log "Navigate to 'http://#{server_fqdn}/mt/mt.cgi' to complete movabletype installation" do
  action :nothing
end

template "#{node[:movabletype][:dir]}/mt5/mt-config.cgi" do
  source "mt-config.cgi.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :database        => node[:movabletype][:db][:database],
    :user            => node[:movabletype][:db][:user],
    :password        => node[:movabletype][:db][:password],
    :dir            => node[:movabletype][:dir]+"/mt5/",
    :server_fqdn    => server_fqdn+"/mt5/"
  )
  notifies :write, resources(:log => "Navigate to 'http://#{server_fqdn}/mt/mt.cgi' to complete movabletype installation")
end

include_recipe %w{php::php5 php::module_mysql}

web_app "movabletype" do
  template "movabletype.conf.erb"
  docroot "#{node[:movabletype][:dir]}"
  server_name server_fqdn
  server_aliases node.fqdn
end

# Install http://www.movabletype.org/downloads/stable/MT-4.34-en.tar.gz

remote_file "#{Chef::Config[:file_cache_path]}/MT-4.3-en.tar.gz" do
  checksum node[:movabletype][:checksum] 
  source "http://www.movabletype.org/downloads/archives/4.x/MT-4.3-en.tar.gz"
  Chef::Log.info("Fetching file for MT4")
  Chef::Log.info(source)
  mode "0644"
end     

directory "#{node[:movabletype][:dir]}/mt4/" do
  owner "www-data"
  group "www-data"
  mode "0755"
  action :create
end

execute "untar-movabletype" do
  cwd node[:movabletype][:dir]+"/mt4/"
  command "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/MT-4.3-en.tar.gz"
  creates "#{node[:movabletype][:dir]}/mt4/mt-config.cgi"
end  

template "#{node[:movabletype][:dir]}/mt4/mt-config.cgi" do
  source "mt-config.cgi.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :database        => node[:movabletype][:db][:database],
    :user            => node[:movabletype][:db][:user],
    :password        => node[:movabletype][:db][:password],
    :dir            => node[:movabletype][:dir]+"/mt4/",
    :server_fqdn    => server_fqdn+"/mt4/"
  )
end  
directory "#{node[:movabletype][:dir]}/mt4/mt-static/support" do
  owner "www-data"
  group "www-data"
  mode "0777"
  action :create
  recursive true
end   
