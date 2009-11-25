%w{ apache2-threaded-dev }.each do |pkg|
  package pkg
end

remote_file "/tmp/mod_xsendfile-0.9.tar.gz" do
  source "http://tn123.ath.cx/mod_xsendfile/mod_xsendfile-0.9.tar.gz"
  mode 0644
end

bash "install mod_xsendfile" do
  cwd "/tmp"
  code <<-EOH
  tar zxvf mod_xsendfile-0.9.tar.gz
  cd mod_xsendfile-0.9 
  apxs2 -cia mod_xsendfile.c 
  touch /etc/apache2/mods-available/xsendfile.load 
  echo LoadModule xsendfile_module /usr/lib/apache2/modules/mod_xsendfile.so >> /etc/apache2/mods-available/xsendfile.load
  a2enmod xsendfile 
  EOH
  not_if { File.exists?("/usr/lib/apache2/modules/mod_xsendfile.so") }
end