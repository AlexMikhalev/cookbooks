include_recipe "build-essential"
include_recipe "java"
%w{wget curl uuid-runtime default-jre-headless fuse-utils attr openjdk-6-jdk ant libfuse-dev libglobus-openssl-dev}.each do |devpkg|
  package devpkg
end

xtreemfs_version = node[:xtreemfs][:version]
configure_flags = node[:xtreemfs][:configure_flags].join(" ")

remote_file "/tmp/XtreemFS-#{xtreemfs_version}.tar.gz" do
  source "http://xtreemfs.googlecode.com/files/XtreemFS-#{xtreemfs_version}.tar.gz"
  action :create_if_missing
end

bash "compile_xtreemfs_source" do
  cwd "/tmp"
  code <<-EOH
    tar zxf XtreemFS-#{xtreemfs_version}.tar.gz
    cd XtreemFS-#{xtreemfs_version} && ./configure #{configure_flags}
    make server && make install
    /etc/xos/xtreemfs/postinstall_setup.sh
  EOH
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
