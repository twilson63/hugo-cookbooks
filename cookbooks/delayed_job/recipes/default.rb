['stop','start'].each do |cmd|
  execute "delayed_job_#{cmd}" do
    command "RAILS_ENV=production #{File.join(node[:app_dir] or '/home/ubuntu/apps',node[:application])}/script/delayed_job #{cmd}"
    action :run
  end
end
