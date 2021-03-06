#
# Author:: nollieheel
# Cookbook Name:: chef-drupal
# Recipe:: drush
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

vars = node['chef-drupal']

directory vars['drush']['inst_dir'] do
  owner     'root'
  group     'root'
  mode      0755
  recursive true
end

full_url = "#{vars['drush']['base_url']}/"\
           "drush-#{vars['drush']['version']}.tar.gz"

tar_extract full_url do
  target_dir    vars['drush']['inst_dir']
  compress_char 'z'
  tar_flags     ['--strip-components 1']
  creates       "#{vars['drush']['inst_dir']}/drush"
  user          'root'
  group         'root'
end

link "#{vars['drush']['bin_dir']}/drush" do
  to        "#{vars['drush']['inst_dir']}/drush"
  link_type :symbolic
end
