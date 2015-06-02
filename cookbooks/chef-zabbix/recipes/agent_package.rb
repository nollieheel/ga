#
# Author:: nollieheel
# Cookbook Name:: chef-zabbix
# Recipe:: agent_package
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

# NOTE:
# Clients will have to manually open their port 10050 before 
# using this recipe. It can't be included here because iptable
# setup in different systems vary too much.

include_recipe "#{cookbook_name}::install_repo"

package node['chef-zabbix']['install']['agent_packages'] do
  if node['platform_family'] == 'rhel'
    flush_cache(
      :before => true
    )
  end
end

service node['chef-zabbix']['etc']['service_name_agent'] do
  if node['platform_family'] == 'rhel'
    restart_command '/sbin/service zabbix-agent try-restart'
  end
  supports [:start, :stop, :restart, :status]
  action   [:enable, :start]
end

include_recipe "#{cookbook_name}::agent_config"
