#
# Author:: nollieheel
# Cookbook Name:: chef-drupal
# Definition:: drupal_module
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

define :drupal_module, 
       :dir     => nil,
       :version => nil, 
       :action  => :enable,
       :mods => ['_'] do

  if params[:dir].nil?
    Chef::Log.error('drupal_module requires a working drupal dir')
    raise 'drupal_module requires a working drupal dir'
  end

  drush = "#{node['chef-drupal']['drush']['inst_dir']}/drush "\
          "-y -r #{params[:dir]}"

  mods = false
  if params[:mods]
    mods = params[:mods].map { |m| m == '_' ? params[:name] : m }
  end

  if params[:action] == :enable
    mainmod = params[:name]
    gre = ''
    unless params[:version].nil?
      mainmod << "-#{params[:version]}"
      gre << " | grep '#{params[:version]}'"
    end

    execute "drush_dl_module_#{mainmod}" do
      command "#{drush} dl #{mainmod}"
      not_if "#{drush} pm-list | grep '(#{params[:name]})'#{gre}"
    end

    if mods
      mods.each do |m|
        execute "drush_en_module_#{m}" do
          command "#{drush} en #{m}"
          not_if "#{drush} pm-list | grep '(#{m})' | grep -i 'enabled'"
        end
      end
    end

  elsif params[:action] == :disable
    if mods
      execute "drush_dis_module_#{params[:name]}" do
        command "#{drush} dis #{mods.join(' ')}"
      end
    end

  else
    raise("Unknown parameter '#{params[:action]}' as action")
  end
end
