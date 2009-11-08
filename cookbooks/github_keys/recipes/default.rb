directory '/home/ubuntu/.ssh' do
  owner "ubuntu"
  group "ubuntu"
  mode "0755"
  action :create
  recursive true
end

template "/home/ubuntu/.ssh/hugo_rsa" do
  owner "ubuntu"
  group "ubuntu"
  mode 0600
  source "privatekey.erb"
  variables :privatekey => node[:github][:privatekey]
end

template "/home/ubuntu/.ssh/hugo_rsa.pub" do
  owner "ubuntu"
  group "ubuntu"
  mode 0600
  source "publickey.erb"
  variables :publickey => node[:github][:publickey]
end
