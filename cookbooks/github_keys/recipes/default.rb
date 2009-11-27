directory '/home/ubuntu/.ssh' do
  owner "ubuntu"
  group "ubuntu"
  mode "0700"
  action :create
  recursive true
end

template "/home/ubuntu/.ssh/id_rsa" do
  owner "ubuntu"
  group "ubuntu"
  mode "0600"
  source "privatekey.erb"
  variables :privatekey => node[:github][:privatekey]
  not_if { File.exists?("/home/ubuntu/.ssh/id_rsa") }
end

template "/home/ubuntu/.ssh/id_rsa.pub" do
  owner "ubuntu"
  group "ubuntu"
  mode "0600"
  source "publickey.erb"
  variables :publickey => node[:github][:publickey]
  not_if { File.exists?("/home/ubuntu/.ssh/id_rsa.pub") }
end

template "/home/ubuntu/.ssh/config" do
  owner "ubuntu"
  group "ubuntu"
  mode "0600"
  source "config.erb"
  variables :application => node[:application]
  not_if { File.exists?("/home/ubuntu/.ssh/config") }
end

# template "/home/ubuntu/.ssh/known_hosts" do
#   owner "ubuntu"
#   group "ubuntu"
#   mode "0600"
#   source "known_hosts.erb"
#   variables :known_hosts => node[:ssh][:known_hosts]
# end
