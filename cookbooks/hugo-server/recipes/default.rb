include_recipe "apache2"
include_recipe "passenger_apache2::mod_rails"
include_recipe "sinatra"

# require 'chef-deploy'

appname = "hugo-server"

directory "/home/ubuntu/apps/#{appname}" do
  action :create
  recursive true
end

deploy "/home/ubuntu/apps/#{appname}" do
  repo "git://github.com/twilson63/hugo-server.git"
  branch "HEAD"
  environment "production"
  restart_command "touch tmp/restart.txt"
  shallow_clone true
  action :deploy
end
