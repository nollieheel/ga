#
# Author:: nollieheel
# Cookbook Name:: chef-phpmyadmin-cookbook
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

include_recipe 'tar'

var = node['phpmyadmin']

doc_root = var['install']['doc_root']
url      = var['base_url']
ver      = var['version']
full_url = "#{url}/#{ver}/phpMyAdmin-#{ver}-english.tar.gz/download"
id_file  = "#{doc_root}/RELEASE-DATE-#{ver}"

directory doc_root do
  recursive true
end

tar_extract full_url do
  target_dir doc_root
  user       var['install']['readonly_user']
  group      var['install']['readonly_group']
  tar_flags  ['--strip-components 1']
  creates    id_file
  not_if     { ::File.exist?(id_file) }
end
