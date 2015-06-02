#
# Author:: nollieheel
# Cookbook Name:: chef-zabbix
# Recipe:: server_package
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

include_recipe "#{cookbook_name}::server_iptables"
include_recipe "#{cookbook_name}::install_repo"

package node['chef-zabbix']['install']['server_packages'] do
  if node['platform_family'] == 'rhel'
    flush_cache(
      :before => true
    )
  end
end

service node['chef-zabbix']['etc']['service_name_server'] do
  if node['platform_family'] == 'rhel'
    restart_command '/sbin/service zabbix-server try-restart'
  end
  supports [:start, :stop, :restart, :status]
  action   [:enable, :start]
end

service node['chef-zabbix']['etc']['apache_name'] do
  case node['platform_family']
  when 'rhel'
    restart_command '/sbin/service httpd restart && sleep 1'
    reload_command  '/sbin/service httpd graceful'
  when 'debian'
    provider Chef::Provider::Service::Debian
  end
  supports [:start, :restart, :reload, :status]
  action   [:enable, :start]
end

#
# TODO
#
# Put in certificates and stuff if the site uses https.
# Debian/Ubuntu also has a different method of installation. 
# It's interactive. Not supported yet.

if node['platform_family'] == 'rhel'
  # Make sure to establish this exception rule in SELinux
  execute 'setsebool -P httpd_can_network_connect=true' do
    only_if "sestatus | grep -e '^SELinux status' | grep 'enabled'"
  end

  mysqlcommand = lambda do |scrname|
    scrdir = Dir.glob('/usr/share/doc/zabbix-server-mysql-*/create').first
    scrfile = File.join(scrdir, scrname)
    raise "Unable to find mysql script #{scrfile}" unless File.exist?(scrfile)

    <<-SHELL.gsub(/\s+/, ' ').strip!
      mysql -u #{node['chef-zabbix']['db']['user']}
      -p'#{node['chef-zabbix']['db']['pass']}'
      #{node['chef-zabbix']['db']['name']} < #{scrfile}
    SHELL
  end

  execute 'mysql_create_zabbix_schema' do
    notifies :run, 'execute[mysql_create_zabbix_images]', :immediately
    command lazy { mysqlcommand.call('schema.sql') }
  end

  execute 'mysql_create_zabbix_images' do
    action   :nothing
    notifies :run, 'execute[mysql_create_zabbix_data]', :immediately
    command lazy { mysqlcommand.call('images.sql') }
  end

  execute 'mysql_create_zabbix_data' do
    action  :nothing
    command lazy { mysqlcommand.call('data.sql') }
  end
end

include_recipe "#{cookbook_name}::server_config"
