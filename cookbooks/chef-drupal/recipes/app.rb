#
# Author:: nollieheel
# Cookbook Name:: chef-drupal
# Recipe:: app
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

include_recipe "#{cookbook_name}::drush"

drush = "#{node['chef-drupal']['drush']['inst_dir']}/drush -y"
doc_root = node['chef-drupal']['install']['doc_root']
parent_dir = ::File.dirname(doc_root)
project_name = ::File.basename(doc_root)

directory parent_dir do
  recursive true
end

execute 'download-drupal' do
  cwd parent_dir
  command "#{drush} dl drupal-#{node['chef-drupal']['version']} "\
          "--destination=#{parent_dir} "\
          "--drupal-project-rename='#{project_name}'"
  not_if "#{drush}/drush -r #{doc_root} status "\
         "| grep #{node['chef-drupal']['version']}"
end

if node['chef-drupal']['site_install']
  inst = node['chef-drupal']['site_install']
  execute 'install-drupal-site' do
    command "#{drush} -r #{doc_root} site-install "\
            "--account-name=#{inst[:account_name]} "\
            "--account-pass='#{inst[:account_pass]}' "\
            "--site-name='#{inst[:site_name]}' "\
            "--db-url=mysql://#{node['chef-drupal']['db']['user']}"\
              ":'#{node['chef-drupal']['db']['pass']}'"\
              "@#{node['chef-drupal']['db']['host']}"\
              ":#{node['chef-drupal']['db']['port']}"\
              "/#{node['chef-drupal']['db']['name']}"
  end
end

node['chef-drupal']['enable_modules'].each do |m|
  if m.is_a?(Hash)
    drupal_module m[:mod] do
      dir doc_root
      version m[:version]
      mods m[:en]
    end
  else
    drupal_module m do
      dir doc_root
    end
  end
end

drupal_module 'disable_starting_drupal_modules' do
  dir doc_root
  mods node['chef-drupal']['disable_modules']
  action :disable
end

execute "#{drush} -r #{doc_root} php-eval 'node_access_rebuild();'"
