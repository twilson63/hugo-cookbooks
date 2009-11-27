appname = node[:application]

### Do Database config
template "/home/ubuntu/apps/#{appname}/shared/config/database.yml" do
  owner "ubuntu"
  group "ubuntu"
  source "database.erb"
end