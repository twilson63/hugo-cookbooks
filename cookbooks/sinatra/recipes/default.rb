# Sqlite

include_recipe "sqlite"
apt_package "libsqlite3-dev" do
  action :install
end
 
gem_package "sqlite3-ruby" do
  action :install
end 

gem_package "rack" do
  action :install
end

gem_package "sinatra" do
  action :install
end

# Thin

gem_package "thin" do
  action :install
end


