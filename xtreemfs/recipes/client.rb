include_recipe "java"
%w{wget curl uuid-runtime fuse-utils attr}.each do |devpkg|
  package devpkg
end
#   for source needs openssl-devel
xtreemfs_arch=node[:xtreemfs][:architecture]
xtreemfs_version = node[:xtreemfs][:version]

  pkg_path="#{Chef::Config[:file_cache_path]}/xtreemfs-client_#{xtreemfs_version}_#{xtreemfs_arch}.deb"
  Chef::Log.info("Define file")
  Chef::Log.info(pkg_path)
  remote_file(pkg_path) do 
    source "http://download.opensuse.org/repositories/home:/xtreemfs/xUbuntu_#{node[:platform_version]}/#{xtreemfs_arch}/xtreemfs-client_#{xtreemfs_version}_#{xtreemfs_arch}.deb"
    action :create_if_missing
    Chef::Log.info("Fetching file")
    Chef::Log.info(source) 
  end
  dpkg_package(pkg_path) do
    source pkg_path
    action :install
  end 