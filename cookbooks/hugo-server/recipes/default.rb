require 'chef-deploy'

include_recipe "sinatra"
#include_recipe "ruby-git"

chef-deploy "/apps/hugo-server" do
  repo "git://github.com/twilson63/hugo-server.git"
  branch "HEAD"
  environment "production"
  restart_command "touch tmp/restart.txt"
  shallow_clone true
  action :deploy


end
