# add chefserver 
# 
# bash "set_hostname" do
# user "root"
#   code <<-EOH
#   hostname chefserver
#   echo chefserver> /etc/hostname
#   IPADDR=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
#   HOSTNAME=chefserver
#   sed -i "s/127.0.0.1[[:space:]]localhost/127.0.0.1    localhost\n$IPADDR  chefserver.scilogonline.com chefserver\n/g" /etc/hosts > /dev/null
#   EOH
# end  
# 
# ruby "get_ip_current" do
# user "root"  
#   cwd "/tmp"
#   code <<-EOD
#   require 'socket'
#   ip_current=Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
#   Chef::Log.info("Logging ip address")
#   Chef::Log.info(ip_current)
#   EOD
# end      

Chef::Log.info("Trying to get node name")
Chef::Log.info(node[:name])  
Chef::Log.info(node[:node_name])
Chef::Log.info(node.name)
 
template "/usr/bin/update_hostname" do
  source "update_hostname.erb"
  owner "root"
  group "root"
  mode "0755"
  variables(
    :node_name     => node.name
  )
end

execute "update_hostname" do
  command "/usr/bin/update_hostname"
  action :run
end   

# cookbook_file "/usr/bin/get_ip" do
#   source "get_ip.sh"
#   mode 0755
# end  
# execute "get_ip" do
#   command "/usr/bin/get_ip"   #{node[:apache][:dir]}
#   creates "/tmp/ip_current"
#   action :run
# end  
      

# cookbook_file "/usr/bin/update_hostname" do
#   source "update_hostname.sh"
#   mode 0755
# end  
# execute "update_hostname" do
#   command "/usr/bin/update_hostname #{node.name}"   
#   creates "/tmp/ip_current"
#   action :run
# end  
#         


    
