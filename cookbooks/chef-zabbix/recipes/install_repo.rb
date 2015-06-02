#
# Author:: nollieheel
# Cookbook Name:: chef-zabbix
# Recipe:: install_repo
#
# Copyright 2015, nollieheel (iskitingbords@gmail.com)
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

include_recipe 'apt::default' if node['platform_family'] == 'debian'

repo_filename = node['chef-zabbix']['repo']['package_url'].split('/').last

remote_file "#{Chef::Config[:file_cache_path]}/#{repo_filename}" do
  source node['chef-zabbix']['repo']['package_url']
  action :create_if_missing
end

case node['platform_family']
when 'rhel'
  yum_package node['chef-zabbix']['repo']['package_name'] do
    source "#{Chef::Config[:file_cache_path]}/#{repo_filename}"
    action :install
  end

when 'debian'
  dpkg_package node['chef-zabbix']['repo']['package_name'] do
    source   "#{Chef::Config[:file_cache_path]}/#{repo_filename}"
    action   :install
    notifies :run, 'execute[apt-get update]', :immediately
  end
end
