%w{ unzip openjdk-6-jdk }.each do |pkg|
  package pkg
end
# http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperServer%203.7.0%20RC/jasperserver-ce-3.7.0-RC-bin.zip/download

remote_file "/tmp/jasperserver-ce-3.7.0-RC-bin" do
  source "http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperServer%203.7.0%20RC/jasperserver-ce-3.7.0-RC-linux-installer.bin/download"
  mode 0644
end

# Not working need to spend time to correct!
# bash "install jasper server" do
#   cwd "/tmp"
#   code <<-EOH
#   chmod +x jasperserver-ce-3.7.0-RC-bin
#   echo -en "\n\n\n\ny\n\n\n\n\n\n\nn\nn\n\nn\n" | ./jasperserver-ce-3.7.0-RC-bin
#   cd jasperserver-ce-3.7.0
#   ./jasperctrl.sh start
#   EOH
#   not_if { File.exists?("/home/ubuntu/jasperserver-ce-3.7.0") }
# end