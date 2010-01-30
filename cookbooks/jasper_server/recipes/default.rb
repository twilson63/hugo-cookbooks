%w{ unzip openjdk-6-jdk }.each do |pkg|
  package pkg
end

directory "/home/ubuntu/apps" do
  owner "ubuntu"
  group "ubuntu"
  action :create
  recursive true
end

# http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperServer%203.7.0%20RC/jasperserver-ce-3.7.0-RC-bin.zip/download
remote_file "/home/ubuntu/apps/jasperserver-3.5.0-linux-installer.bin" do
  source "http://downloads.sourceforge.net/project/jasperserver/JasperServer/JasperServer%203.5.0/jasperserver-3.5.0-linux-installer.bin?use_mirror=hivelocity"
  mode 0644
end

# Not working need to spend time to correct!
bash "install jasper server" do
  cwd "/home/ubuntu/apps"
  code <<-EOH
  sudo chmod +x jasperserver-3.5.0-linux-installer.bin
  echo -en "\n\n\n\ny\n\n\n\n\n\n\nn\nn\n\nn\n" | ./jasperserver-3.5.0-linux-installer.bin
  cd jasperserver-3.5.0
  ./jasperctrl.sh start
  EOH
  not_if { File.exists?("/home/ubuntu/apps/jasperserver-3.5.0") }
end