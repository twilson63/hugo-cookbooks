template "~/.ssh/id_rsa" do
  mode 0644
  source "privatekey.erb"
end

template "~/.ssh/id_rsa.pub" do
  mode 0644
  source "publickey.erb"
end
