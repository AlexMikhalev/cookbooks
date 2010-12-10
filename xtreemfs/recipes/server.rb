#
# Cookbook Name:: xtreemfs
# Recipe:: default
#
# Copyright 2010, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"
%w{wget curl uuid-runtime fuse-utils attr}.each do |devpkg|
  package devpkg
end   

xtreemfs_version = node[:xtreemfs][:version] 

#FIXME: use ohai "platform_version"=>"10.04" and node[:kernel][:machine]
%w{xtreemfs-backend xtreemfs-server xtreemfs-tools}.each do |xtreempkg|
  pkg_path="#{Chef::Config[:file_cache_path]}/#{xtreempkg}_#{xtreemfs_version}_all.deb"
  Chef::Log.info("Define file")
  Chef::Log.info(pkg_path)
  remote_file(pkg_path) do
    source "http://download.opensuse.org/repositories/home:/xtreemfs/xUbuntu_#{node[:platform_version]}/all/#{xtreempkg}_#{xtreemfs_version}_all.deb"
    action :create_if_missing
    Chef::Log.info("Fetching file")
    Chef::Log.info(source) 
  end
  dpkg_package(pkg_path) do
    source pkg_path
    action :install
  end 
  
end


service "xtreemfs-dir" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

service "xtreemfs-mrc" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end  


service "xtreemfs-osd" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end   




