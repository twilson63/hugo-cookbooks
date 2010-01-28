appname = node[:application]
app_branch = node[:app][:branch] if node[:app] && node[:app][:branch]

directory "/home/ubuntu/apps/#{appname}" do
  owner "ubuntu"
  group "ubuntu"
  action :create
  recursive true
end

directory "/home/ubuntu/apps/#{appname}/shared/config" do
  owner "ubuntu"
  group "ubuntu"
  action :create
  recursive true
end

### Create Log Directory
directory "/home/ubuntu/apps/#{appname}/shared/log" do
  owner "ubuntu"
  group "ubuntu"
  action :create
  recursive true
end

if @node[:database] and @node[:database][:name]
  ### Do Database config
  template "/home/ubuntu/apps/#{appname}/shared/config/database.yml" do
    owner "ubuntu"
    group "ubuntu"
    source "database.erb"
  end
  
end

### Apache Config
template "/home/ubuntu/apps/#{appname}/shared/config/apache2.conf" do
  owner "ubuntu"
  group "ubuntu"  
  source "vhost.erb"
end


deploy "/home/ubuntu/apps/#{appname}" do
  if node[:github][:url]
    repo "#{node[:github][:url]}/#{appname}.git"
  end
  user "ubuntu"
  branch app_branch || "HEAD"
  environment "production"
  if node[:app] && node[:app][:restart_command]
    restart_command node[:app][:restart_command]  
  else
    restart_command "touch tmp/restart.txt"
  end
  shallow_clone true
  if node[:app] && node[:app][:migrate]
    migrate node[:app][:migrate]
  else
    migrate false
  end
  if node[:app] && node[:app][:migration_command]
    migration_command node[:app][:migration_command]  
  else
    migration_command "rake db:migrate"
  end
  action :deploy
end



if node[:app] and node[:app][:ssl]
  ### Apache SSL Public Key
  template "/etc/ssl/certs/#{node[:customer]}.crt" do
    owner "root"
    group "root"  
    source "publickey.erb"
  end

  ### Apache SSL Private Key
  template "/etc/ssl/certs/#{node[:customer]}.key" do
    owner "root"
    group "root"  
    source "privatekey.erb"
  end

  ### Apache GD Bundle
  template "/etc/ssl/certs/gd_bundle.crt" do
    owner "root"
    group "root"  
    source "gd_bundle.erb"
  end
end

file "/etc/apache2/sites-enabled/000-default" do
  action :delete
end

execute "ln" do
  command "sudo ln -nsf /home/ubuntu/apps/#{appname}/shared/config/apache2.conf /etc/apache2/sites-enabled/#{appname}"
  action :run
end



execute "ln" do
  command "ln -nsf /home/ubuntu/apps/#{appname}/shared/log /home/ubuntu/apps/#{appname}/current/log"
  action :run
end

if @node[:database] and @node[:database][:name]

  execute "ln" do
    command "ln -nsf /home/ubuntu/apps/#{appname}/shared/config/database.yml /home/ubuntu/apps/#{appname}/current/config/database.yml"
    action :run
  end
end

#
# execute "/etc/init.d/apache2" do
#   command "/etc/init.d/apache2 restart"
#   action :run
# end
