#
# Cookbook Name:: bootstrap
# Attributes:: bootstrap
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

validation_token = ""
chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
20.times { |i| validation_token << chars[rand(chars.size-1)] }

set_unless[:bootstrap][:chef][:url_type]   = "http"
set_unless[:bootstrap][:chef][:init_style] = "runit"
set_unless[:bootstrap][:chef][:path]       = "/srv/chef"
set_unless[:bootstrap][:chef][:run_path]   = "/var/run/chef"
set_unless[:bootstrap][:chef][:cache_path] = "/#{bootstrap[:chef][:path]}/cache"
set_unless[:bootstrap][:chef][:serve_path] = "/srv/chef"

set_unless[:bootstrap][:chef][:server_version]  = "0.7.14"
set_unless[:bootstrap][:chef][:client_version]  = "0.7.14"
set_unless[:bootstrap][:chef][:client_interval] = "1800"
set_unless[:bootstrap][:chef][:client_splay]    = "20"
set_unless[:bootstrap][:chef][:log_dir]         = "/var/log/chef"

case bootstrap[:chef][:init_style]
when "runit"
  set_unless[:bootstrap][:chef][:client_log]  = "STDOUT"
  set_unless[:bootstrap][:chef][:server_log]  = "STDOUT"
  set_unless[:bootstrap][:chef][:indexer_log] = "STDOUT"
else
  set_unless[:bootstrap][:chef][:client_log]  = "#{bootstrap[:chef][:log_dir]}/client.log"
  set_unless[:bootstrap][:chef][:server_log]  = "#{bootstrap[:chef][:log_dir]}/server.log"
  set_unless[:bootstrap][:chef][:indexer_log] = "#{bootstrap[:chef][:log_dir]}/indexer.log"
end

set_unless[:bootstrap][:chef][:server_fqdn]  = domain ? "chef.#{domain}" : "chef"
set_unless[:bootstrap][:chef][:server_token] = validation_token
