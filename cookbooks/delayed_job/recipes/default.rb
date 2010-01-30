['stop','start'].each do |cmd|
  execute "delayed_job_#{cmd}" do
    command "RAILS_ENV=production /home/ubuntu/apps/#{node[:application]}/current/script/delayed_job #{cmd}"
    action :run
  end
end
