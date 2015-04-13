#
# Author:: nollieheel
# Cookbook Name:: chef-drupal
# Definition:: drupal_settings
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

# Creates <docroot>/sites/default/settings.php

require 'openssl'
require 'securerandom' 

define :drupal_settings,
       :template          => 'settings.php.erb',
       :cookbook          => 'chef-drupal',
       :db_host           => 'localhost',
       :db_name           => 'drupal',
       :db_port           => '3306',
       :db_user           => 'drupaluser',
       :db_pass           => 'secretpassword',
       :custom_statements => [] do
  settings_path = params[:path] || params[:name]

  Chef::Log.info("Will create #{settings_path} for drupal")

  template settings_path do
    source   params[:template]
    cookbook params[:cookbook]
    mode     0444
    user     params[:user] || node['chef-drupal']['install']['readonly_user']
    group    params[:group] || node['chef-drupal']['install']['readonly_group']

    variables(
      :db_host           => params[:db_host],
      :db_port           => params[:db_port],
      :db_name           => params[:db_name],
      :db_user           => params[:db_user],
      :db_pass           => params[:db_pass],
      :hash_salt         => OpenSSL::Digest::SHA256.hexdigest(SecureRandom.hex),
      :custom_statements => params[:custom_statements]
    )
  end
end
