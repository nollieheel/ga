#
# Author:: nollieheel
# Cookbook Name:: chef-phpmyadmin-cookbook
# Definition:: phpmyadmin_settings
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

# Creates <docroot>/config.inc.php

require 'openssl'
require 'securerandom'

# Example of db_map (with defaults):
# [
#   {
#     :verbose   => '',
#     :host      => 'localhost',
#     :port      => '3306',
#     :socket    => '',
#     :con_type  => 'tcp',
#     :auth_type => 'cookie'
#   }
# ]
define :phpmyadmin_settings,
       :template   => 'config.inc.php.erb',
       :cookbook   => 'chef-phpmyadmin-cookbook',
       :db_map     => [],
       :statements => [] do
  settings_path = params[:path] || params[:name]

  Chef::Log.info("Will create #{settings_path} for phpmyadmin")

  template settings_path do
    cookbook params[:cookbook]
    source   params[:template]
    mode     0444
    user     params[:user] || node['phpmyadmin']['install']['readonly_user']
    group    params[:group] || node['phpmyadmin']['install']['readonly_group']

    variables(
      :db_map     => params[:db_map],
      :secret     => OpenSSL::Digest::SHA256.hexdigest(SecureRandom.hex),
      :statements => params[:statements]
    )
  end
end
