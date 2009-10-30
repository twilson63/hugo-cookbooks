# Sqlite

include_recipe "sqlite"

gem_package "sqlite3-ruby" do
  action :install
end 

# Thin

gem_package "thin" do
  action :install
end

# Sinatra

gem_package "sinatra" do
  action :install
end

