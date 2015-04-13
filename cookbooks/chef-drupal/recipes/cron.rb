#
# Author:: nollieheel
# Cookbook Name:: chef-drupal
# Recipe:: cron
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

include_recipe 'cron'

drush = "#{node['chef-drupal']['drush']['inst_dir']}/drush -y "\
        "-r #{node['chef-drupal']['install']['doc_root']}"

Chef::Log.info('Disable Drupal automated cron (cron_safe_threshold=0)')
execute 'disable_drupal_automated_cron' do
  command "#{drush} vset cron_safe_threshold 0"
end

Chef::Log.info('Create crontab entry for Drupal cron jobs')
cron_file = ::File.join(node['chef-drupal']['install']['doc_root'], 'cron.php')
freq = node['chef-drupal']['cron']['freq']

cron 'drupal_hourly_cron' do
  command "#{drush} core-cron"
  minute  freq[0]
  hour    freq[1]
  day     freq[2]
  month   freq[3]
  weekday freq[4]
  mailto  node['chef-drupal']['cron']['mailto']
  only_if { ::File.exist?(cron_file) }
end
