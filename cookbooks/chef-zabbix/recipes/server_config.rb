#
# Author:: nollieheel
# Cookbook Name:: chef-zabbix
# Recipe:: server_config
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

case node['platform']
when 'redhat', 'centos'
  # Configure the Zabbix server
  zserverdir = '/etc/zabbix'
  zservice   = node['chef-zabbix']['etc']['service_name_server']

  template "#{zserverdir}/zabbix_server.conf" do
    only_if  { Dir.exist?(zserverdir) }
    action   :create
    mode     0644
    notifies :restart, "service[#{zservice}]"

    variables(
      :dbhost     => node['chef-zabbix']['db']['host'],
      :dbname     => node['chef-zabbix']['db']['name'],
      :dbuser     => node['chef-zabbix']['db']['user'],
      :dbpassword => node['chef-zabbix']['db']['pass'],

      :listenport  => node['chef-zabbix']['server']['listen_port'],
      :logfile     => node['chef-zabbix']['server']['log_file'],
      :logfilesize => node['chef-zabbix']['server']['log_file_size'],

      :advanced_params => node['chef-zabbix']['server']['advanced_params']
    )
  end

  # Configure apache2
  apacheconf  = '/etc/httpd/conf'
  apacheconfd = '/etc/httpd/conf.d'
  aservice    = node['chef-zabbix']['etc']['apache_name']

  template "#{apacheconf}/httpd.conf" do
    only_if  { Dir.exist?(apacheconf) }
    action   :create
    mode     0644
    notifies :restart, "service[#{aservice}]"

    variables(
      :server_name => node['chef-zabbix']['web']['server_name']
    )
  end

  template "#{apacheconfd}/zabbix.conf" do
    only_if  { Dir.exist?(apacheconfd) }
    action   :create
    mode     0644
    notifies :restart, "service[#{aservice}]"

    variables(
      :php_values => node['chef-zabbix']['install']['php_values']
    )
  end

when 'debian', 'ubuntu'
  #
  # TODO not done yet
  # Looks like configuring zabbix in Debian is interactive.

  #
  # TODO 
  # Configure PHP server depending on platform (Debian/Ubuntu)
  # https://www.zabbix.com/documentation/2.4/manual/installation/install_from_packages
end
