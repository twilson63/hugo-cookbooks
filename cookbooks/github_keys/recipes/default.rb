template "~/.ssh/id_rsa" do
  mode 0644
  source "privatekey.erb"
  variables :privatekey => node[:github][:privatekey]
end

template "~/.ssh/id_rsa.pub" do
  mode 0644
  source "publickey.erb"
  variables :publickey => node[:github][:publickey]
end
