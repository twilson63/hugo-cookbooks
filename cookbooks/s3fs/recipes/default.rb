%w{ pkg-config libcurl4-openssl-dev libfuse-dev libfuse2 }.each do |pkg|
  package pkg
end

remote_file "/tmp/s3fs-r177-source.tar.gz" do
  source "http://s3fs.googlecode.com/files/s3fs-r177-source.tar.gz"
  mode 0644
end

bash "install s3fs" do
  cwd "/tmp"
  code <<-EOH
  tar zxvf s3fs-r177-source.tar.gz
  cd s3fs
  sudo make
  sudo make install
  sudo mkdir -p /mnt/#{ node[:customer] } 
  sudo s3fs #{ node[:customer] }  -o accessKeyId=#{ node[:access_key] } -o secretAccessKey=#{ node[:secret_key] } -o allow_other /mnt/#{ node[:customer] } 

  EOH
  
  not_if { File.exists?("/usr/bin/s3fs") }
end


