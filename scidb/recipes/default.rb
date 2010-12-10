#
# Cookbook Name:: scidb
# Recipe:: default
#
# Copyright 2010, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
# 

%w{curl gcc bzr memcached python-configobj python-coverage python-dev python-nose python-setuptools python-simplejson python-xattr sqlite3 xfsprogs python-webob python-eventlet python-greenlet python-pastedeploy}.each do |devpkg|
  package devpkg
end
# should be working code

execute "install_swift_repo" do
  command "sudo apt-get install python-software-properties && add-apt-repository ppa:swift-core/ppa && apt-get update"
end  

bash "compile_scidb_source" do
  cwd "/tmp"
  code <<-EOH
  EOH
end   