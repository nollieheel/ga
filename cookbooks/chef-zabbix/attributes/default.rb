#
# Author:: nollieheel
# Cookbook Name:: chef-zabbix
# Attribute:: default
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

default['chef-zabbix']['db']['host']      = '127.0.0.1'
default['chef-zabbix']['db']['port']      = '3306'
default['chef-zabbix']['db']['root_pass'] = 'rootpassword'
default['chef-zabbix']['db']['name']      = 'zabbix'
default['chef-zabbix']['db']['user']      = 'zabbixuser'
default['chef-zabbix']['db']['pass']      = 'zabbixpassword'

default['chef-zabbix']['repo']['package_name'] =
  value_for_platform_family(
    'rhel'   => 'zabbix-release-2.4-1.el6.noarch',
    'debian' => 'zabbix-release'
  )

url_pref = 'http://repo.zabbix.com/zabbix/2.4'
default['chef-zabbix']['repo']['package_url'] =
  value_for_platform(
    ['redhat', 'centos'] => {
      'default' => "#{url_pref}/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm"
    },
    'debian' => {
      'default' => "#{url_pref}/debian/pool/main/z/zabbix-release/zabbix-release_2.4-1+wheezy_all.deb"
    },
    'ubuntu' => {
      'default' => "#{url_pref}/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb"
    }
  )
# The attribute 'package_url' will determine the version of zabbix.
# In this case, it's whatever is latest on the 2.4 line.

front_package = value_for_platform_family(
  'rhel'   => 'zabbix-web-mysql',
  'debian' => 'zabbix-frontend-php'
)
default['chef-zabbix']['install']['server_packages'] =
  ['zabbix-server-mysql', front_package]
default['chef-zabbix']['install']['agent_packages'] =
  ['zabbix-agent']
default['chef-zabbix']['install']['php_values'] = {
  'max_execution_time'  => '300',
  'memory_limit'        => '256M',
  'post_max_size'       => '16M',
  'upload_max_filesize' => '2M',
  'max_input_time'      => '300',
  'date.timezone'       => 'America/New_York'
}

default['chef-zabbix']['web']['https']       = false
default['chef-zabbix']['web']['server_name'] = 'zabbix.example.com'

default['chef-zabbix']['server']['listen_port']     = '10051'
default['chef-zabbix']['server']['log_file']        = '/var/log/zabbix/zabbix_server.log'
default['chef-zabbix']['server']['log_file_size']   = '0'
default['chef-zabbix']['server']['advanced_params'] = {}

default['chef-zabbix']['agent']['listen_port']            = '10050'
default['chef-zabbix']['agent']['hostname']               = 'Zabbix Server'
default['chef-zabbix']['agent']['server_ip']              = '127.0.0.1'
default['chef-zabbix']['agent']['enable_active_checks']   = true
default['chef-zabbix']['agent']['refresh_active_checks']  = 120
default['chef-zabbix']['agent']['enable_remote_commands'] = '0'
default['chef-zabbix']['agent']['advanced_params']        = {}
default['chef-zabbix']['agent']['user_params']            = {}

default['chef-zabbix']['etc']['apache_name'] =
  value_for_platform_family(
    'rhel'   => 'httpd',
    'debian' => 'apache2'
  )
default['chef-zabbix']['etc']['service_name_server'] = 'zabbix-server'
default['chef-zabbix']['etc']['service_name_agent']  = 'zabbix-agent'
