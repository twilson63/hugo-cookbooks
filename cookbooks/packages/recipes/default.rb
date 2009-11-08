node[:package_list].each do |pkg|
  package pkg[:name] do
    if pkg[:version] && !pkg[:version].empty?
      version pkg[:version]
    end
    if pkg[:source]
      source pkg[:source]
    end
    action :install
  end
end