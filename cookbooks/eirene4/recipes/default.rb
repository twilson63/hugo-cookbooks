appname = node[:application]

### Do Database config
template "/home/ubuntu/apps/#{appname}/shared/config/database.yml" do
  owner "ubuntu"
  group "ubuntu"
  source "database.erb"
end

template "/home/ubuntu/apps/#{appname}/shared/config/s3.yml" do
  owner "ubuntu"
  group "ubuntu"
  source "s3.erb"
end

execute "ln" do
  command "ln -nsf /home/ubuntu/apps/#{appname}/shared/config/s3.yml /home/ubuntu/apps/#{appname}/current/config/s3.yml"
  action :run
end

bucket = node[:customer] || 'eirene'
bucket = 'eirene' if node[:customer] == 'revcare'

template "/home/ubuntu/apps/#{appname}/shared/config/bucket.yml" do
  owner "ubuntu"
  group "ubuntu"
  source "bucket.erb"
end

execute "ln" do
  command "ln -nsf /home/ubuntu/apps/#{appname}/shared/config/bucket.yml /home/ubuntu/apps/#{appname}/current/config/bucket.yml"
  action :run
end

if node[:app] and node[:app][:ssl]

  @web_url = node[:app][:url]

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