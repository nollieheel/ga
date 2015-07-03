#
# Author:: nollieheel
# Cookbook Name:: chef-zabbix
# Recipe:: agent_config
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

aagent    = node['chef-zabbix']['agent']
zagentdir = '/etc/zabbix'
zagentd   = node['chef-zabbix']['etc']['service_name_agent']

template "#{zagentdir}/zabbix_agentd.conf" do
  only_if  { Dir.exist?(zagentdir) }
  action   :create
  mode     0644
  notifies :restart, "service[#{zagentd}]"

  variables(
    :server_ip              => aagent['server_ip'],
    :listen_port            => aagent['listen_port'],
    :enable_active_checks   => aagent['enable_active_checks'],
    :hostname               => aagent['hostname'],
    :refresh_active_checks  => aagent['refresh_active_checks'],
    :enable_remote_commands => aagent['enable_remote_commands'],
    :advanced_params        => aagent['advanced_params'],
    :user_params            => aagent['user_params']
  )
end
