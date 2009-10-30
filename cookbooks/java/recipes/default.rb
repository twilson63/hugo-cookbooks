#
# Cookbook Name:: java
# Recipe:: default
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

java_pkg = value_for_platform(
  "ubuntu" => {
    "default" => "sun-java6-jdk"
  },
  "debian" => {
    "default" => "sun-java6-jdk"
  },
  "default" => "sun-java6-jdk"
)

execute "update-java-alternatives" do
  command "update-java-alternatives -s java-6-sun"
  only_if do platform?("ubuntu", "debian") end
  ignore_failure true
  returns 1
  action :nothing
end

package java_pkg do
  response_file "java.seed"
  action :install
  notifies :run, resources(:execute => "update-java-alternatives"), :immediately
end

package "ant"
