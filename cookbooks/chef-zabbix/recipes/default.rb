#
# Author:: nollieheel
# Cookbook Name:: chef-zabbix
# Recipe:: default
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

# This cookbook requires that you have already set up mysql/mariadb,
# have the zabbix user created, and the database created as well.
# Enter the appropriate values as attributes.

include_recipe "#{cookbook_name}::server_package"
