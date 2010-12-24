include_recipe "build-essential"
include_recipe "subversion"
include_recipe "java"
%w{wget curl uuid-runtime default-jre-headless fuse-utils attr subversion ant openjdk-6-jdk  libssl-dev libfuse-dev fuse-utils}.each do |devpkg|
  package devpkg
end

xtreemfs_version = node[:xtreemfs][:version]
# configure_flags = node[:xtreemfs][:configure_flags].join(" ")
# 
# remote_file "/tmp/XtreemFS-#{xtreemfs_version}.tar.gz" do
#   source "http://xtreemfs.googlecode.com/files/XtreemFS-#{xtreemfs_version}.tar.gz"
#   action :create_if_missing
# end 

# subversion "CouchDB Edge" do
#   repository "http://svn.apache.org/repos/asf/couchdb/trunk"
#   revision "HEAD"
#   destination "/opt/mysources/couch"
#   action :sync
# end 


bash "compile_xtreemfs_source" do
  cwd "/tmp"
  code <<-EOH
    svn checkout http://xtreemfs.googlecode.com/svn/branches/XtreemFS-1.2.4
    cd XtreemFS-1.2.4
    make && make install
    /etc/xos/xtreemfs/postinstall_setup.sh
    /etc/xos/xtreemfs/generate_uuid /etc/xos/xtreemfs/dirconfig.properties
    /etc/xos/xtreemfs/generate_uuid /etc/xos/xtreemfs/mrcconfig.properties
    /etc/xos/xtreemfs/generate_uuid /etc/xos/xtreemfs/osdconfig.properties
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
