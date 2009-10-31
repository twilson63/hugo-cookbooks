include_recipe "sinatra"

directory '/tmp/myapp' do
  owner "ubuntu"
  group "ubuntu"
  mode "0755"
  action :create
end

template "/tmp/myapp/config.ru" do
  source "config.ru.erb"

end

template "/tmp/myapp/app.rb" do

  source "app.rb.erb"
end
#remote_directory "/tmp/myapp" do
#  source "app"
#  files_backup 10
#  files_owner "ubuntu"
#  files_group "ubuntu"
#  files_mode "0644"
#  owner "ubuntu"
#  group "ubuntu"
#  mode "0755"
#end

# remote_file "/tmp/myapp/config.ru" do
#   source "config.ru"
# end
# 
# remote_file "/tmp/myapp/app.rb" do
#   source "app.rb"
# end

# thin start -R config.ru
execute "thin" do
  command "thin start -R config.ru -d"
  creates "tmp/pids/thin.pid"
  cwd "/tmp/myapp"
  action :run
end



