#
# Author:: nollieheel
# Cookbook Name:: chef-phpmyadmin-cookbook
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

default['phpmyadmin']['version']  = '4.4.11'
default['phpmyadmin']['base_url'] = 'https://files.phpmyadmin.net/phpMyAdmin'

default['phpmyadmin']['install']['doc_root']       = '/var/www/pma'
default['phpmyadmin']['install']['readonly_user']  = 'root'
default['phpmyadmin']['install']['readonly_group'] = 'root'
