#include_recipe "git"
#include_recipe "github_keys"
#include_recipe "ssh_known_hosts"

# Include Hugo Server Stuff

# include_recipe "apache2"
# include_recipe "apache2::mod_ssl"
# 
# include_recipe "passenger_apache2::mod_rails"

# include_recipe "rails"
# include_recipe "sinatra"

appname = node[:application]

directory "/home/ubuntu/apps/#{appname}" do
  owner "ubuntu"
  group "ubuntu"
  action :create
  recursive true
end

deploy "/home/ubuntu/apps/#{appname}" do
  repo "#{node[:github][:url]}/#{appname}.git"
  user "ubuntu"
  branch "HEAD"
  environment "production"
  restart_command "touch tmp/restart.txt"
  shallow_clone true
  action :deploy
end

directory "/home/ubuntu/apps/#{appname}/shared/config" do
  owner "ubuntu"
  group "ubuntu"
  action :create
  recursive true
end

### Do Database config
template "/home/ubuntu/apps/#{appname}/shared/config/database.yml" do
  owner "ubuntu"
  group "ubuntu"
  source "database.erb"
end

### Apache Config
template "/home/ubuntu/apps/#{appname}/shared/config/apache2.conf" do
  owner "ubuntu"
  group "ubuntu"  
  source "vhost.erb"
end

file "/etc/apache2/sites-enabled/000-default" do
  action :delete
end

execute "ln" do
  command "sudo ln -nsf /home/ubuntu/apps/#{appname}/shared/config/apache2.conf /etc/apache2/sites-enabled/#{appname}"
  action :run
end

execute "ln" do
  command "ln -nsf /home/ubuntu/apps/#{appname}/shared/config/database.yml /home/ubuntu/apps/#{appname}/current/config/database.yml"
  action :run
end



#
# execute "/etc/init.d/apache2" do
#   command "/etc/init.d/apache2 restart"
#   action :run
# end
