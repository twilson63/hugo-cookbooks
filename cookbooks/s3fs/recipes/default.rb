remote_file "/tmp/s3fs-r177-source.tar.gz" do
  source "http://s3fs.googlecode.com/files/s3fs-r177-source.tar.gz"
  mode 0644
end

bash "install s3fs" do
  cwd "/tmp"
  code <<-EOH
  tar zxvf s3fs-r177-source.tar.gz
  cd s3fs
  make
  make install
  EOH
  not_if { File.exists?("/tmp/s3fs-r177-source.tar.gz") }
end