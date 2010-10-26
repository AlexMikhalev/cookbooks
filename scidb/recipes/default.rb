#
# Cookbook Name:: scidb
# Recipe:: default
#
# Copyright 2010, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
# 

%w{ build-essential cmake libboost1.40-all-dev postgresql-8.4 libpqxx-3.0 libpqxx3-dev libprotobuf5 libprotobuf-dev protobuf-compiler doxygen flex bison libxerces-c-dev libxerces-c3.1 liblog4cxx10 liblog4cxx10-dev libcppunit-1.12-1 libcppunit-dev libbz2-dev postgresql-contrib libconfig++8 libconfig++8-dev libconfig8-dev subversion}.each do |devpkg|
  package devpkg
end
# should be working code
bash "compile_scidb_source" do
  cwd "/tmp"
  code <<-EOH
  EOH
end   