#
# Author:: nollieheel
# Cookbook Name:: chef-drupal
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

default['chef-drupal']['drush']['version'] = '7.x-5.9'
default['chef-drupal']['drush']['inst_dir'] = '/usr/local/drush'
default['chef-drupal']['drush']['base_url'] = 'http://ftp.drupal.org/files/projects/'
default['chef-drupal']['drush']['bin_dir'] = '/usr/local/bin'

default['chef-drupal']['version'] = '7.34'

default['chef-drupal']['install']['user'] = 'www-data'
default['chef-drupal']['install']['group'] = 'www-data'
default['chef-drupal']['install']['doc_root'] = '/var/www/drupal'

# Set this to 'false' if you don't want 'drush site-install' performed.
default['chef-drupal']['site_install'] = {
  :account_name => 'admin',
  :account_pass => 'password',
  :site_name => 'Example Site'
}
# Module elements can be:
#   "string"
#   {:mod => "string", :en = false}
#   {:mod => "string", :en = ["_", "string1", "string2"...]}
#   {:mod => "string", :version => "string", :en = ["string1", "string2"...]}
default['chef-drupal']['enable_modules'] = [
  'views',
  'webform'
]
default['chef-drupal']['disable_modules'] = []

default['chef-drupal']['db']['host'] = '127.0.0.1'
default['chef-drupal']['db']['port'] = '3306'
default['chef-drupal']['db']['name'] = 'drupal'
default['chef-drupal']['db']['user'] = 'drupaluser'
default['chef-drupal']['db']['pass'] = 'secretpassword'
