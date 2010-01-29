appname = node[:application]

['database','s3','bucket','jasper'].each do |file|
  template "/home/ubuntu/apps/#{appname}/shared/config/#{file}.yml" do
    owner "ubuntu"
    group "ubuntu"
    source "#{file}.erb"
  end

end

['s3','bucket','jasper'].each do |file|
  execute "ln" do
    command "ln -nsf /home/ubuntu/apps/#{appname}/shared/config/#{file}.yml /home/ubuntu/apps/#{appname}/current/config/#{file}.yml"
    action :run
  end
end

#include_recipe "delayed_job"

if node[:app] and node[:app][:ssl]

  directory "/home/ubuntu/apps/#{appname}/shared/public" do
    owner "ubuntu"
    group "ubuntu"
    action :create
    recursive true
  end
  

  template "/home/ubuntu/apps/#{appname}/shared/public/htaccess" do
    owner "ubuntu"
    group "ubuntu"
    source "htaccess.erb"
  end


  execute "ln" do
    command "ln -nsf /home/ubuntu/apps/#{appname}/shared/public/htaccess /home/ubuntu/apps/#{appname}/current/public/.htaccess"
    action :run
  end

end