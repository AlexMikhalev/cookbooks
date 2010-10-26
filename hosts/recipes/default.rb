# Find all nodes, sorting by Chef ID so their
# order doesn't change between runs.
hosts = search(:node, "*:*", "X_CHEF_id_CHEF_X asc")
 
template "/etc/hosts" do
  source "hosts.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :hosts => hosts,
    :fqdn => node[:fqdn],
    :hostname => node[:hostname],
    :ipaddress=> node[:ipadress]
    )
end        

# hosts     = {}
# localhost = nil
# 
# search(:node, "*", %w(ipaddress fqdn dns_aliases)) do |n|
#   # node own's record, store in localhost
#   if n["ipaddress"] == node[:ipaddress]
#     localhost = n
#   else
#     hosts[n["ipaddress"]] = n
#   end
# end
# 
# template "/etc/hosts" do
#   source "hosts.erb"
#   mode 0644
#   variables(:localhost => localhost, :hosts => hosts)
# end  