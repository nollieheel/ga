#
# All rights reserved - Do Not Redistribute
#
# Author:: nollieheel
# Cookbook Name:: chef-zabbix
# Recipe:: server_iptables
#
# Copyright 2015, nollieheel (iskitingbords@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# TODO We need to do this for Debian systems, too.
#
if %w{ redhat centos }.include?(node['platform'])
  include_recipe 'simple_iptables'

  simple_iptables_policy 'INPUT' do
    policy 'ACCEPT'
  end

  simple_iptables_rule 'established' do
    chain 'INPUT'
    rule '-m conntrack --ctstate ESTABLISHED,RELATED'
    jump 'ACCEPT'
    weight 1
  end

  simple_iptables_rule 'icmp' do
    chain 'INPUT'
    rule '--proto icmp'
    jump 'ACCEPT'
    weight 2
  end

  simple_iptables_rule 'loopback' do
    chain 'INPUT'
    rule '--in-interface lo'
    jump 'ACCEPT'
    weight 3
  end

  simple_iptables_rule 'ssh' do
    chain 'INPUT'
    rule '--proto tcp --dport 22 -m conntrack --ctstate NEW'
    jump 'ACCEPT'
    weight 4
  end

  simple_iptables_rule 'web_port' do
    chain 'INPUT'
    rule '--proto tcp --dport 80'
    jump 'ACCEPT'
    weight 20
  end

  if node['chef-zabbix']['web']['https']
    simple_iptables_rule 'secure_web_port' do
      chain 'INPUT'
      rule '--proto tcp --dport 443'
      jump 'ACCEPT'
      weight 21
    end
  end

  simple_iptables_rule 'zabbix_server' do
    chain 'INPUT'
    rule "--proto tcp --dport #{node['chef-zabbix']['server']['listen_port']}"
    jump 'ACCEPT'
    weight 22
  end

  simple_iptables_rule 'zabbix_agent' do
    chain 'INPUT'
    rule "--proto tcp --dport #{node['chef-zabbix']['agent']['listen_port']}"
    jump 'ACCEPT'
    weight 23
  end

  simple_iptables_rule 'reject' do
    chain 'INPUT'
    rule ''
    jump 'REJECT --reject-with icmp-host-prohibited'
    weight 90
  end

  simple_iptables_rule 'reject' do
    direction 'FORWARD'
    chain 'FORWARD'
    rule ''
    jump 'REJECT --reject-with icmp-host-prohibited'
    weight 90
  end
end
